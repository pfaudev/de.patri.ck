<#

  .SYNOPSIS
  Sortiert Bilder basierend auf einem Datum im Dateinamen in Ordnerstrukturen.
    
  .DESCRIPTION
  Dieses Skript scannt einen Quellordner rekursiv.
  Es sucht nach Mustern wie "YYYY-MM-DD" oder "YYYYMMDD".
  Gültige Dateien werden in eine Struktur verschoben: Zielordner \ Jahr \ Datum (YYYY-MM-DD).
  Der **Quellordner wird beim Start des Skripts interaktiv abgefragt**.
    
  .NOTES
  Autor: patr.ck
  Datum: 25.11.2025 (Angepasst: 29.11.2025)
  
#>
  # --- AUSFÜHRUNG ERLAUBEN ---
  Set-ExecutionPolicy Bypass -Scope Process -Force
  # --- KONFIGURATION ---
  $sourcePath = "$PWD\INPUT"
  $destPath   = "$PWD\OUTPUT"

  $doMove     = $false   # $true setzt die Dateien wirklich in Bewegung!

  $extensions   = @(".jpg", ".jpeg", ".png", ".gif", ".heic", ".mp4")
  $regexPattern = "(?<dsep>(?:19|20)\d{2}-\d{2}-\d{2})|(?<dnosep>(?:19|20)\d{2}\d{2}\d{2})"

  Write-Host "--- Starte Analyse (Android-Mode) von $sourcePath ---" -ForegroundColor Cyan
  $files = Get-ChildItem -Path $sourcePath -Recurse | Where-Object { 
    $_.Extension -in $extensions -and -not $_.PSIsContainer 
  }

  foreach ($file in $files) {
    if($file.Name -match $regexPattern) {
      $dateStr = if ($Matches['dsep']) { $Matches['dsep'] } else { $Matches['dnosep'] }
      $format  = if ($Matches['dsep']) { "yyyy-MM-dd" } else { "yyyyMMdd" }
      try {
        $realDate = [DateTime]::ParseExact($dateStr, $format, $null)
        $yearFolder  = $realDate.ToString("yyyy")
        $albumFolder = $realDate.ToString("yyyy-MM-dd")
        $targetDir   = Join-Path -Path $destPath -ChildPath "$yearFolder\$albumFolder"
        
        if($doMove) {
          if(-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }
          $destFile = Join-Path $targetDir $file.Name
          if(-not (Test-Path $destFile)) {
            Move-Item -Path $file.FullName -Destination $targetDir
            Write-Host "[MOVE] $($file.Name) -> $yearFolder\$albumFolder" -ForegroundColor Green
          } else {
            Write-Host "[SKIP] Datei existiert bereits im Ziel: $($file.Name)" -ForegroundColor Yellow
          }
        } else {
          Write-Host "[SIM] Würde verschieben: $($file.Name) nach $yearFolder\$albumFolder" -ForegroundColor Gray
        }
      } catch {
        Write-Host "[ERR] Ungültiges Datum in: $($file.Name)" -ForegroundColor Red
      }
    }
  }

  # --- PHP GALERIE GENERATOR (Der "Einzeiler" + CSS) ---
  if($doMove) {
    Write-Host "--- Erstelle PHP Mini-Galerie ---" -ForegroundColor Cyan
    $phpContent = @'
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <title>Foto-Sammlung</title>
  <style>
    body { font-family: sans-serif; background: #222; color: #eee; margin: 0; padding: 20px; }
    h1 { text-align: center; border-bottom: 2px solid #444; padding-bottom: 10px; }
    .gallery { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; }
    .card { background: #333; border-radius: 8px; overflow: hidden; transition: transform 0.2s; }
    .card:hover { transform: scale(1.02); box-shadow: 0 5px 15px rgba(0,0,0,0.5); }
    .card img { width: 100%; height: 200px; object-fit: cover; display: block; }
    .info { padding: 10px; text-align: center; font-size: 0.8em; color: #aaa; }
    a { color: inherit; text-decoration: none; }
  </style>
</head>
<body>

  <div class="gallery"><?php
    
    $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('.'));
    foreach($files as $file) {
      if($file->isFile() && preg_match('/\.(jpg|jpeg|png|gif)$/i', $file->getFilename())) {
        $path = $file->getPathname();
        $displayPath = str_replace('.\\', '', $path); 
        echo "<a href='$path' target='_blank' class='card'>
          <img src='$path' loading='lazy' alt='Foto'>
          <div class='info'>" . dirname($displayPath) . "<br>" . $file->getFilename() . "</div>
        </a>";
      }
    }

  ?></div>
    
</body>
</html>
'@

    $phpFile = Join-Path $destPath "gallerie.php"
    Set-Content -Path $phpFile -Value $phpContent -Encoding UTF8
    Write-Host "[PHP] Galerie erstellt: $phpFile" -ForegroundColor Magenta
  }
  
  Write-Host "--- Fertig ---" -ForegroundColor Cyan