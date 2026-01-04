<?php

  require_once 'config.php';
  require_once 'db.php';

  function validate_input($data, $type = 'string') {
    $data = trim($data);
    switch($type) {
      case 'int':
      return filter_var($data, FILTER_VALIDATE_INT) !== false ? (int)$data : null;
      
	  case 'date':
      $d = DateTime::createFromFormat('Y-m-d', $data);
      return $d && $d->format('Y-m-d') === $data ? $data : null;
      
	  default:
      return htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
    }
  }

  function log_error($message) {
    if(ENABLE_ERROR_LOG) {
      error_log(date('[Y-m-d H:i:s] ').$message.PHP_EOL, 3, LOG_FILE);
    }
  }

  function redirect_with_message($msg, $type = 'success') {
    header("Location: " . $_SERVER['PHP_SELF'] . "?msg=" . urlencode($msg) . "&type=" . $type);
    exit;
  }

  $msg = "";
  $msg_type = "success";

  if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';    
    try {
      switch($action) {
        case 'add_set':
              $name = validate_input($_POST['name']);
              $image = validate_input($_POST['image']);
              $own = validate_input($_POST['own'], 'int');
              $anz_items = validate_input($_POST['anz_items'], 'int');
              $tags = validate_input($_POST['tags']);
              $datum = validate_input($_POST['datum'], 'date');
              
              if(empty($name)) {
                  throw new Exception("Set-Name darf nicht leer sein.");
              }
              if($anz_items === null || $anz_items < 1) {
                  throw new Exception("Anzahl Items muss mindestens 1 sein.");
              }
              if(!$datum) {
                  throw new Exception("Ungültiges Datum.");
              }
              
              $stmt = mysqli_prepare($dbc, "INSERT INTO clipper_sets(name, image, own, anz_items, tags, datum) VALUES (?, ?, ?, ?, ?, ?)");
              mysqli_stmt_bind_param($stmt, 'ssiiss', $name, $image, $own, $anz_items, $tags, $datum);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Set '$name' erfolgreich erstellt!");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        case 'edit_set':
              $id = validate_input($_POST['id'], 'int');
              $name = validate_input($_POST['name']);
              $image = validate_input($_POST['image']);
              $own = validate_input($_POST['own'], 'int');
              $anz_items = validate_input($_POST['anz_items'], 'int');
              $tags = validate_input($_POST['tags']);
              $datum = validate_input($_POST['datum'], 'date');
              
              if(empty($name)) {
                  throw new Exception("Set-Name darf nicht leer sein.");
              }
              if($anz_items === null || $anz_items < 1) {
                  throw new Exception("Anzahl Items muss mindestens 1 sein.");
              }
              if(!$datum) {
                  throw new Exception("Ungültiges Datum.");
              }
              
              $stmt = mysqli_prepare($dbc, "UPDATE clipper_sets SET name=?, image=?, own=?, anz_items=?, tags=?, datum=? WHERE _id=?");
              mysqli_stmt_bind_param($stmt, 'ssiissi', $name, $image, $own, $anz_items, $tags, $datum, $id);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Set '$name' aktualisiert!");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        case 'del_set':
              $id = validate_input($_POST['id'], 'int');
              
              // Erst zugehörige Items löschen
              $stmt_items = mysqli_prepare($dbc, "DELETE FROM clipper_items WHERE set_id = ?");
              mysqli_stmt_bind_param($stmt_items, 'i', $id);
              mysqli_stmt_execute($stmt_items);
              mysqli_stmt_close($stmt_items);
              
              // Dann das Set löschen
              $stmt = mysqli_prepare($dbc, "DELETE FROM clipper_sets WHERE _id = ?");
              mysqli_stmt_bind_param($stmt, 'i', $id);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Set und zugehörige Clipper gelöscht.");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        case 'add_item':
              $set_id = validate_input($_POST['set_id'], 'int');
              $name = validate_input($_POST['name']);
              $image = validate_input($_POST['image']);
              $own = validate_input($_POST['own'], 'int');
              $tags = validate_input($_POST['tags']);
              $datum = validate_input($_POST['datum'], 'date');
              
              if(empty($name)) {
                  throw new Exception("Clipper-Name darf nicht leer sein.");
              }
              if(!$datum) {
                  throw new Exception("Ungültiges Datum.");
              }
              
              $stmt = mysqli_prepare($dbc, "INSERT INTO clipper_items(set_id, name, image, own, tags, datum) VALUES (?, ?, ?, ?, ?, ?)");
              mysqli_stmt_bind_param($stmt, 'ississ', $set_id, $name, $image, $own, $tags, $datum);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Clipper '$name' hinzugefügt!");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        case 'edit_item':
              $id = validate_input($_POST['id'], 'int');
              $name = validate_input($_POST['name']);
              $image = validate_input($_POST['image']);
              $own = validate_input($_POST['own'], 'int');
              $tags = validate_input($_POST['tags']);
              
              if(empty($name)) {
                  throw new Exception("Clipper-Name darf nicht leer sein.");
              }
              
              $stmt = mysqli_prepare($dbc, "UPDATE clipper_items SET name=?, image=?, own=?, tags=? WHERE _id=?");
              mysqli_stmt_bind_param($stmt, 'ssisi', $name, $image, $own, $tags, $id);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Clipper '$name' aktualisiert!");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        case 'delete_item':
              $id = validate_input($_POST['id'], 'int');
              
              $stmt = mysqli_prepare($dbc, "DELETE FROM clipper_items WHERE _id = ?");
              mysqli_stmt_bind_param($stmt, 'i', $id);
              
              if(mysqli_stmt_execute($stmt)) {
                  redirect_with_message("Clipper entfernt.");
              } else {
                  throw new Exception(mysqli_error($dbc));
              }
              mysqli_stmt_close($stmt);
        break;
              
        default:
        throw new Exception("Unbekannte Aktion: $action");
        }
    } catch(Exception $e) {
        log_error("Fehler bei Action '$action': ".$e->getMessage());
        redirect_with_message("Fehler: ".$e->getMessage(), 'error');
    }
    
    mysqli_close($dbc);
    exit;
}

  if(isset($_GET['msg'])) {
    $msg = htmlspecialchars($_GET['msg']);
    $msg_type = $_GET['type'] ?? 'success';
  }

  $filter_own = $_GET['filter_own'] ?? '';
  $filter_tags = $_GET['filter_tags'] ?? '';
  $sort_by = $_GET['sort_by'] ?? 'date_desc';

  $sets = [];
  $items_by_set = [];
  $edit_set = null;
  $edit_item = null;

  $sql_sets = "SELECT s.*, COUNT(i._id) as current_count FROM clipper_sets s LEFT JOIN clipper_items i ON s._id = i.set_id";

$where_conditions = [];
$params = [];
$param_types = '';

  if($filter_own !== '') {
    $where_conditions[] = "s.own = ?";
    $params[] = (int)$filter_own;
    $param_types .= 'i';
  }

  if(!empty($filter_tags)) {
    $where_conditions[] = "s.tags LIKE ?";
    $params[] = '%' . $filter_tags . '%';
    $param_types .= 's';
  }

  if(!empty($where_conditions)) {
    $sql_sets .= " WHERE " . implode(" AND ", $where_conditions);
  }

  $sql_sets .= " GROUP BY s._id";

  switch($sort_by) {
    case 'name_asc':	$sql_sets .= " ORDER BY s.name ASC";   break;
    case 'name_desc':	$sql_sets .= " ORDER BY s.name DESC";   break;
    case 'date_asc':	$sql_sets .= " ORDER BY s.datum ASC";   break;
    case 'completion':	$sql_sets .= " ORDER BY (COUNT(i._id) / s.anz_items) DESC";   break;
    default:			$sql_sets .= " ORDER BY s.datum DESC, s._id DESC";
  }

if(!empty($params)) {
    $stmt = mysqli_prepare($dbc, $sql_sets);
    mysqli_stmt_bind_param($stmt, $param_types, ...$params);
    mysqli_stmt_execute($stmt);
    $res_sets = mysqli_stmt_get_result($stmt);
} else {
    $res_sets = mysqli_query($dbc, $sql_sets);
}

if($res_sets) {
    while($row = mysqli_fetch_assoc($res_sets)) {
        $sets[] = $row;
    }
    mysqli_free_result($res_sets);
    if(!empty($params)) mysqli_stmt_close($stmt);
}

  $sql_items = "SELECT * FROM clipper_items ORDER BY _id ASC";
  $res_items = mysqli_query($dbc, $sql_items);

  if($res_items) {
    while($item = mysqli_fetch_assoc($res_items)) {
      $items_by_set[$item['set_id']][] = $item;
    }
    mysqli_free_result($res_items);
  }

// Set zum Bearbeiten laden
if(isset($_GET['edit_set'])) {
    $edit_id = validate_input($_GET['edit_set'], 'int');
    $stmt = mysqli_prepare($dbc, "SELECT * FROM clipper_sets WHERE _id = ?");
    mysqli_stmt_bind_param($stmt, 'i', $edit_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $edit_set = mysqli_fetch_assoc($result);
    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
}

// Item zum Bearbeiten laden
  if(isset($_GET['edit_item'])) {
    $edit_id = validate_input($_GET['edit_item'], 'int');
    $stmt = mysqli_prepare($dbc, "SELECT * FROM clipper_items WHERE _id = ?");
    mysqli_stmt_bind_param($stmt, 'i', $edit_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $edit_item = mysqli_fetch_assoc($result);
    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
  }

  mysqli_close($dbc);

$total_sets = count($sets);
$owned_sets = count(array_filter($sets, fn($s) => $s['own'] == 1));
$total_items = array_sum(array_map(fn($s) => $s['current_count'], $sets));
$completion_rate = $total_sets > 0 ? round((array_sum(array_map(fn($s) => min(100, ($s['current_count'] / $s['anz_items']) * 100), $sets)) / $total_sets)) : 0;
?><!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= APP_NAME ?> // Clipper Collection Helper</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            dark: '#232323',
            card: '#18181b',
            neon: '#ff0180',
            accent: '#ff9100'
          },
          fontFamily: {
            mono: ['Courier New', 'monospace'],
          }
        }
      }
    }
  </script>
  <style>
    body { background-color: #0f0f13; color: #e4e4e7; }
    .neon-shadow { box-shadow: 0 0 10px rgba(255, 94, 0, 0.2); }
    .neon-text { text-shadow: 0 0 5px rgba(255, 94, 0, 0.5); }
    ::-webkit-scrollbar { width: 8px; }
    ::-webkit-scrollbar-track { background: #18181b; }
    ::-webkit-scrollbar-thumb { background: #3f3f46; border-radius: 4px; }
    ::-webkit-scrollbar-thumb:hover { background: #ff5e00; }
  </style>
</head>
<body class="min-h-screen p-4 md:p-8 font-sans">

  <header class="mb-10 flex flex-col md:flex-row justify-between items-center border-b border-gray-800 pb-6">
    <div>
      <h1 class="text-4xl font-black uppercase tracking-tighter text-white"><?= substr(APP_NAME, 0, 7) ?><span class="text-neon neon-text"><?= substr(APP_NAME, 7) ?></span></h1>
      <p class="text-gray-500 text-sm font-mono uppercase mt-1">ClipperCollectorHelper v<?= APP_VERSION ?></p>
    </div>
    <?php if($msg): ?><div class="mt-4 md:mt-0 <?= $msg_type === 'error' ? 'bg-red-900/30 border-red-500/50 text-red-400' : 'bg-green-900/30 border-green-500/50 text-green-400' ?> border px-4 py-2 rounded text-sm font-mono"><?= $msg ?></div><?php endif; ?>
  </header>
  
  <!-- Statistiken -->
  <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
    <div class="bg-card p-4 rounded border border-gray-800">
      <div class="text-gray-400 text-xs font-mono mb-1">TOTAL SETS</div>
      <div class="text-2xl font-bold text-neon"><?= $total_sets ?></div>
    </div>
    <div class="bg-card p-4 rounded border border-gray-800">
      <div class="text-gray-400 text-xs font-mono mb-1">OWNED SETS</div>
      <div class="text-2xl font-bold text-green-400"><?= $owned_sets ?></div>
    </div>
    <div class="bg-card p-4 rounded border border-gray-800">
      <div class="text-gray-400 text-xs font-mono mb-1">TOTAL ITEMS</div>
      <div class="text-2xl font-bold text-accent"><?= $total_items ?></div>
    </div>
    <div class="bg-card p-4 rounded border border-gray-800">
      <div class="text-gray-400 text-xs font-mono mb-1">COMPLETION</div>
      <div class="text-2xl font-bold text-blue-400"><?= $completion_rate ?>%</div>
    </div>
  </div>

  <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
        
    <aside class="lg:col-span-3 space-y-8">
            
      <!-- Set Formular -->
      <div class="bg-card p-6 rounded-lg border border-gray-800 neon-shadow relative overflow-hidden">
        <div class="absolute top-0 left-0 w-1 h-full bg-neon"></div>
        <h2 class="text-xl font-bold mb-4 flex items-center gap-2"><?= $edit_set ? '✏️ Set Bearbeiten' : '➕ Neues Set' ?></h2>
                
        <form method="POST" action="index.php">
          <input type="hidden" name="action" value="<?= $edit_set ? 'edit_set' : 'add_set' ?>"> 
          <?php if($edit_set): ?><input type="hidden" name="id" value="<?= $edit_set['_id'] ?>"><?php endif; ?>
          <div class="space-y-3">
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Set Name *</label>
              <input type="text" name="name" required placeholder="z.B. Fire Collection 2024" value="<?= htmlspecialchars($edit_set['name'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none transition-colors">
            </div>
            <div class="grid grid-cols-2 gap-2">
              <div>
                <label class="block text-xs font-mono text-gray-400 mb-1">Image ID</label>
                <input type="text" name="image" placeholder="z.B. fire_set" value="<?= htmlspecialchars($edit_set['image'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
              </div>
               <div>
                <label class="block text-xs font-mono text-gray-400 mb-1">Anz. Items *</label>
                <input type="number" name="anz_items" min="1" required placeholder="4" value="<?= htmlspecialchars($edit_set['anz_items'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
              </div>
            </div>
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Tags</label>
              <input type="text" name="tags" placeholder="fire, limited, rare" value="<?= htmlspecialchars($edit_set['tags'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
            </div>
             <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Datum *</label>
              <input type="date" name="datum" required value="<?= date('Y-m-d', strtotime($edit_set['datum'] ?? 'now')) ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
            </div>
             <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Im Besitz</label>
              <select name="own" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
                <option value="0" <?= ($edit_set['own'] ?? 0) == 0 ? 'selected' : '' ?>>Nein</option>
                <option value="1" <?= ($edit_set['own'] ?? 0) == 1 ? 'selected' : '' ?>>Ja</option>
              </select>
            </div>
            
           <div class="flex gap-2 pt-2">
              <button type="submit" class="flex-1 bg-neon hover:bg-accent text-black font-bold py-2 px-4 rounded transition-transform hover:scale-105">
                <?= $edit_set ? 'Speichern' : 'Erstellen' ?>
              </button>
              <?php if($edit_set): ?>
                <a href="index.php" class="bg-gray-700 hover:bg-gray-600 text-white py-2 px-4 rounded text-center">✖</a>
              <?php endif; ?>
            </div>
          </div>
        </form>
        
      </div>

      <!-- Item Formular -->
      <div class="bg-card p-6 rounded-lg border border-gray-800">
        <h2 class="text-xl font-bold mb-4 text-gray-300">
          <?= $edit_item ? 'Clipper Bearbeiten' : 'Clipper Hinzufügen' ?>
        </h2>
                
        <?php if(empty($sets)): ?>
          <p class="text-sm text-yellow-500 font-mono">Erstelle erst ein Set!</p>
        <?php else: ?>
        <form method="POST" action="index.php">
          <input type="hidden" name="action" value="<?= $edit_item ? 'edit_item' : 'add_item' ?>">
          <?php if($edit_item): ?><input type="hidden" name="id" value="<?= $edit_item['_id'] ?>"><?php endif; ?>
                        
          <div class="space-y-3">
            <?php if(!$edit_item): ?>
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Zu welchem Set? *</label>
              <select name="set_id" required class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
                <?php foreach($sets as $s): ?>
                  <option value="<?= $s['_id'] ?>"><?= htmlspecialchars($s['name']) ?></option>
                <?php endforeach; ?>
              </select>
            </div>
            <?php endif; ?>
                            
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Name *</label>
              <input type="text" name="name" required placeholder="z.B. Fire Lighter" value="<?= htmlspecialchars($edit_item['name'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
            </div>

            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Image</label>
              <input type="text" name="image" placeholder="z.B. fire_01" value="<?= htmlspecialchars($edit_item['image'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none text-xs">
            </div>

            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Im Besitz</label>
              <select name="own" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
                <option value="0" <?= ($edit_item['own'] ?? 0) == 0 ? 'selected' : '' ?>>Nein</option>
                <option value="1" <?= ($edit_item['own'] ?? 0) == 1 ? 'selected' : '' ?>>Ja</option>
              </select>
            </div>
                            
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Tags</label>
              <input type="text" name="tags" placeholder="rare, exclusive" value="<?= htmlspecialchars($edit_item['tags'] ?? '') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
            </div>
            
            <?php if(!$edit_item): ?>                    
            <div>
              <label class="block text-xs font-mono text-gray-400 mb-1">Datum *</label>
              <input type="date" name="datum" required value="<?= date('Y-m-d') ?>" class="w-full bg-dark border border-gray-700 rounded p-2 text-white focus:border-neon focus:outline-none">
            </div>
            <?php endif; ?>

            <div class="flex gap-2 pt-2">
              <button type="submit" class="flex-1 border border-neon text-neon hover:bg-neon hover:text-black font-bold py-2 px-4 rounded transition-colors">
                <?= $edit_item ? 'Speichern' : 'Hinzufügen' ?>
              </button>
              <?php if($edit_item): ?>
                <a href="index.php" class="bg-gray-700 hover:bg-gray-600 text-white py-2 px-4 rounded text-center">✖</a>
              <?php endif; ?>
            </div>
          </div>
        </form>
      <?php endif; ?>
    </div>
  </aside>

  <main class="lg:col-span-9">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
      <h2 class="text-2xl font-bold border-l-4 border-neon pl-4">Meine Sammlung</h2>
      
      <!-- Filter & Sortierung -->
      <form method="GET" class="flex flex-wrap gap-2 text-sm">
        <select name="filter_own" onchange="this.form.submit()" class="bg-card border border-gray-700 rounded px-3 py-1 text-white focus:border-neon focus:outline-none">
          <option value="">Alle Sets</option>
          <option value="1" <?= $filter_own === '1' ? 'selected' : '' ?>>Nur Owned</option>
          <option value="0" <?= $filter_own === '0' ? 'selected' : '' ?>>Nur Missing</option>
        </select>
        
        <input type="text" name="filter_tags" value="<?= htmlspecialchars($filter_tags) ?>" placeholder="Tags..." class="bg-card border border-gray-700 rounded px-3 py-1 text-white focus:border-neon focus:outline-none w-32">
        
        <select name="sort_by" onchange="this.form.submit()" class="bg-card border border-gray-700 rounded px-3 py-1 text-white focus:border-neon focus:outline-none">
          <option value="date_desc" <?= $sort_by === 'date_desc' ? 'selected' : '' ?>>Datum ↓</option>
          <option value="date_asc" <?= $sort_by === 'date_asc' ? 'selected' : '' ?>>Datum ↑</option>
          <option value="name_asc" <?= $sort_by === 'name_asc' ? 'selected' : '' ?>>Name ↑</option>
          <option value="name_desc" <?= $sort_by === 'name_desc' ? 'selected' : '' ?>>Name ↓</option>
          <option value="completion" <?= $sort_by === 'completion' ? 'selected' : '' ?>>Completion</option>
        </select>
        
        <?php if($filter_own !== '' || $filter_tags !== '' || $sort_by !== 'date_desc'): ?>
          <a href="index.php" class="bg-gray-700 hover:bg-gray-600 text-white px-3 py-1 rounded">Reset</a>
        <?php endif; ?>
      </form>
    </div>

    <?php if(empty($sets)): ?>
      <div class="text-center py-20 bg-card rounded border border-dashed border-gray-700">
        <div class="text-6xl mb-4">📦</div>
        <p class="text-gray-500 text-xl">Noch keine Sets vorhanden.</p>
        <p class="text-gray-600 text-sm mt-2">Starte links im Formular.</p>
      </div>
    <?php endif; ?>

    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-6">
      <?php foreach($sets as $set): ?>
        <?php 
          $set_items = $items_by_set[$set['_id']] ?? [];
          $expected_count = $set['anz_items'] ?? 1;
          $percent = ($set['current_count'] / $expected_count) * 100;
          if($percent > 100) $percent = 100;
          $color_class = $percent >= 100 ? 'bg-green-500' : 'bg-neon';
        ?>
                    
          <div class="bg-card rounded-xl overflow-hidden shadow-lg border border-gray-800 hover:border-gray-600 transition-all group">
            <div class="p-4 bg-dark/50 flex justify-between items-start border-b border-gray-800">
              <div class="flex-1">
                <h3 class="font-bold text-lg text-white group-hover:text-neon transition-colors">
                  <?= htmlspecialchars($set['name']) ?>
                </h3>
                <div class="flex gap-2 items-center mt-1">
                  <span class="text-xs font-mono text-gray-400">📅 <?= htmlspecialchars($set['datum'] ?? 'Unbekannt') ?></span>
                  <?php if(!empty($set['tags'])): ?>
                    <span class="text-xs font-mono text-gray-500">🏷️ <?= htmlspecialchars($set['tags']) ?></span>
                  <?php endif; ?>
                </div>
              </div>
              <div class="flex gap-2 ml-2">
                <?php if($set['own'] == 1): ?>
                  <span class="text-green-400 text-xs">✓ OWNED</span>
                <?php endif; ?>
                <a href="?edit_set=<?= $set['_id'] ?>" class="text-xs text-blue-400 hover:text-blue-300 hover:underline">Edit</a>
                <form method="POST" onsubmit="return confirm('Set \'<?= htmlspecialchars($set['name']) ?>\' wirklich löschen?');">
                  <input type="hidden" name="action" value="del_set">
                  <input type="hidden" name="id" value="<?= $set['_id'] ?>">
                  <button class="text-xs text-red-500 hover:text-red-400 hover:underline">Del</button>
                </form>
              </div>
            </div>

            <div class="w-full h-1 bg-gray-800"><div class="h-full <?= $color_class ?> transition-all duration-300" style="width: <?= $percent ?>%"></div></div>

            <div class="p-4">
              <div class="flex justify-between text-xs text-gray-500 mb-3 font-mono">
                <span>STATUS</span>
                <span class="<?= $percent >= 100 ? 'text-green-400' : 'text-neon' ?> font-bold"><?= $set['current_count'] ?> / <?= $expected_count ?> (<?= round($percent) ?>%)</span>
              </div>

              <div class="grid grid-cols-4 gap-2">
                <?php foreach($set_items as $item): ?>
                  <div class="relative group/item aspect-[3/5] bg-dark rounded border border-gray-700 flex flex-col items-center justify-center overflow-hidden hover:border-neon transition-colors">
                    <?php if($item['image']): ?>
                      <img src="<?= ITEM_IMAGE_BASE_URL.htmlspecialchars($item['image']) ?>.png" 
                           alt="<?= htmlspecialchars($item['name']) ?>"
                           class="absolute inset-0 w-full h-full object-cover opacity-60 group-hover/item:opacity-100 transition-opacity"
                           onerror="this.onerror=null; this.src=''; this.parentElement.innerHTML+='<div class=&quot;text-neon text-2xl&quot;>ERROR</div>';">
                    <?php else: ?>
                      <div class="text-neon text-2xl">🔥</div>
                    <?php endif; ?>
                    
                    <?php if($item['own'] == 1): ?>
                      <div class="absolute top-1 right-1 bg-green-500 text-white text-[8px] px-1 rounded">✓</div>
                    <?php endif; ?>
                    
                    <div class="absolute inset-0 bg-black/90 flex flex-col items-center justify-center opacity-0 group-hover/item:opacity-100 transition-opacity p-2 text-center">
                      <span class="text-[10px] font-bold text-white break-all mb-1"><?= htmlspecialchars($item['name']) ?></span>
                      <?php if(!empty($item['tags'])): ?>
                        <span class="text-[8px] text-gray-400 mb-2"><?= htmlspecialchars($item['tags']) ?></span>
                      <?php endif; ?>
                      <div class="flex gap-1">
                        <a href="?edit_item=<?= $item['_id'] ?>" class="text-[10px] text-blue-400 border border-blue-400 px-2 py-0.5 rounded hover:bg-blue-400 hover:text-white transition-colors">✏️</a>
                        <form method="POST" onsubmit="return confirm('Clipper wirklich löschen?');">
                          <input type="hidden" name="action" value="delete_item">
                          <input type="hidden" name="id" value="<?= $item['_id'] ?>">
                          <button class="text-[10px] text-red-500 border border-red-500 px-2 py-0.5 rounded hover:bg-red-500 hover:text-white transition-colors">🗑️</button>
                        </form>
                      </div>
                    </div>
                  </div>
                <?php endforeach; ?>
			  
                <?php for($i=0; $i<($expected_count - $set['current_count']); $i++): ?>
                  <div class="aspect-[3/5] bg-dark/30 rounded border border-dashed border-gray-800 flex items-center justify-center hover:border-gray-700 transition-colors">
                    <span class="text-gray-700 text-xs">Empty</span>
                  </div>
                <?php endfor; ?>
              </div>
            </div>
          </div>
        <?php endforeach; ?>
      </div>
    </main>
    
  </div>

  <footer class="mt-12 text-center text-gray-600 text-xs font-mono border-t border-gray-800 pt-6">
    <?= APP_NAME ?> v<?= APP_VERSION ?> // Made with 🔥 // <?= count($sets) ?> Sets • <?= $total_items ?> Items
  </footer>

</body>
</html>
