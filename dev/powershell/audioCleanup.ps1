<#

  Bereinigen von Audio-Sammlungen:
  - .aiff zu .aif umbenennen
  - Falls .aif bereits existiert → .aiff löschen
  - Trash-Ordner automatisch erstellen
  - Trash nach Datum sortieren
  - DryRun-Modus
  - Logfile
  
#>
  # --- AUSFÜHRUNG ERLAUBEN ---
  Set-ExecutionPolicy Bypass -Scope Process -Force
  
  param([switch]$DryRun, [string]$RootPath = (Get-Location).Path)

  # === Einstellungen ===
  $Today = (Get-Date).ToString('yyyy-MM-dd')
  $TrashPath = Join-Path $RootPath "Trash/$Today"
  $LogFile = Join-Path $RootPath "AudioCleanup_$Today.log"

  # === Logging Funktion ===
  function Log($msg) {
    $timestamp = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    "$timestamp  $msg" | Out-File -FilePath $LogFile -Append -Encoding UTF8
    Write-Host $msg
  }

  # === Trash anlegen ===
  if(-not $DryRun) {
    if(-not (Test-Path $TrashPath)) {
      New-Item -ItemType Directory -Path $TrashPath | Out-Null
      Log "Trash-Ordner erstellt: $TrashPath"
    }
  }

  Log "Starte Verarbeitung im Ordner: $RootPath"

  # === Alle .aiff Dateien finden ===
  $aiffFiles = Get-ChildItem -Path $RootPath -Recurse -Filter "*.aiff" -File

  foreach($file in $aiffFiles) {
    $newName = [System.IO.Path]::ChangeExtension($file.FullName, '.aif')
    if(Test-Path $newName) {
        Log "EXISTIERT bereits: $(Split-Path $newName -Leaf). Lösche: $($file.Name)"
        if (-not $DryRun) {
            Remove-Item $file.FullName -Force
        }
    } else {
        Log "Umbenennen: $($file.Name) → $(Split-Path $newName -Leaf)"
        if(-not $DryRun) {
          Rename-Item -Path $file.FullName -NewName (Split-Path $newName -Leaf)
        }
    }
  }

  Log "FERTIG."