<?php
  require_once "config.php";
  $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
  if(!$dbc) {    die("<div style='color:red; font-family:sans-serif; padding:20px;'>Verbindung fehlgeschlagen: ".mysqli_connect_error()."<br />Bitte prüfe die Zugangsdaten.</div>");  }
  mysqli_set_charset($dbc, DB_CHARSET);
?>