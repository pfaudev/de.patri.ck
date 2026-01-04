<?php
  // Datenbank-Konfiguration
  define('DB_HOST', 'localhost');
  define('DB_USER', '');
  define('DB_PASS', '');
  define('DB_NAME', '');
  define('DB_CHARSET', 'utf8mb4');  
  // Anwendungs-Konfiguration
  define('APP_NAME', 'ClipperDB');
  define('APP_VERSION', '1.3.0.2');
  define('ITEM_IMAGE_BASE_URL', 'https://app.*******.bplaced.net/img/clipper/items/');
  define('SET_IMAGE_BASE_URL', 'https://app.*******.bplaced.net/img/clipper/sets/');
  // Fehlerbehandlung
  define('ENABLE_ERROR_LOG', true);
  define('LOG_FILE', __DIR__ . '/logs/error.log');  
  // Session-Konfiguration (für zukünftige Erweiterungen)
  define('SESSION_LIFETIME', 3600);
?>