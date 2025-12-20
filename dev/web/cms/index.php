<?php ob_start(); ?>
<!doctype html>
<html lang="de">
<head><?php

  $_SESSION['loggedIn'] = true;

  require "./include/class.loader.php";

  $currentDay   = date("d");
  $day          = date("w");
  $currentMonth = date("n");
  $currentJahr  = date("Y");
  $currentDate  = "<i>".$arr_tage[$day]."</i>, ".$currentDay.".".$currentMonth.".".$currentJahr;

  if(isset($_GET['site']) && $_GET['site'] != "") { $currentPage = $_GET['site']; } else { $currentPage = "start"; }
  if(isset($_GET['kat'])  && $_GET['kat'] != "") {  $currentKat = $_GET['kat']; } else { $currentKat = "none"; }
  if(isset($_GET['data']) && $_GET['data'] != "") { $api = $_GET['data']; } else { $api = "none"; }

  ?><meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>🅲🅼🅺🄾🄽🅂🄾🄻🄴</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" id="picostrap-styles-css" href="https://cdn.livecanvas.com/media/css/library/bundle.css" media="all">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="./assets/css/main.php">
  <link rel="icon" type="image/vnd.microsoft.icon" href="./assets/favicon.ico">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container-fluid">
        <a class="navbar-brand" href="./index.php"><img src="./assets/img/patr.ck_logo.gif" width="125" height="50" class="d-inline-block align-top " alt="LOGO"></a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <div class="navbar-nav ms-auto">
            <a href="./?site=start" class="nav-item nav-link active border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-house-fill px-1 pp-pink"></i> STARTSEiTE</a></li>
            <a href="./?site=audio&kat=none" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-music-note-list px-1 pp-weiss"></i> AUDiO<b class="music-note">DB</b></a>
            <a href="./?site=clipper&kat=none" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-fire px-1 pp-weiss"></i> CLiPPER<b class="music-note">DB</b></a>
            <a href="./?site=linkliste" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-link-45deg px-1 pp-weiss"></i> LiNK<b class="music-note">LiSTE</b></a>
            <a href="./?site=id3&kat=index" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-house-fill px-1 pp-weiss"></i> iD<b class="music-note">3</b>TAGS</a>
            <?php if(isset($_SESSION['loggedIn']) && $_SESSION['loggedIn'] == "true") { ?>
              <a href="./?site=logout" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-person-lock px-1 pp-weiss"></i><b class="pp-hellgrau">L</b>OGOUT</a>
			  <a href="./?site=fm" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-person-lock px-1 pp-weiss"></i><b class="pp-hellgrau">D</b>ATEiEN</a><?php
            } else { ?>
              <a href="./?site=login" class="nav-item nav-link pp-weiss border-bottom-0 border-sm-bottom-0 border-lg-bottom-0 border-xl-bottom-0"><i class="bi bi-person-lock px-1 pp-weiss"></i><b class="pp-hellgrau">L</b>OGiN</a><?php
            }
          ?></div>
        </div>
      </div>
    </nav>

  <main class="container-fluid pp-content py-5">

    <section class="pp-breadcrumb px-2">
      <nav class="pp-breadcrumb-links" style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="#"><i class="bi bi-house-fill px-0 pp-dunkelgrau"></i></a></li>
          <li class="breadcrumb-item active" aria-current="page"><?php echo strtoupper($currentPage); ?></li>
        </ol>
      </nav>
      <div class="pp-breadcrumb-rechts"><?php echo $currentDate; ?></div>
      <div class="clearfix" />
    </section>

    <section class="row px-2"><?php

      switch($currentPage) {
        case "start":     include "start.php";   break;

        case "audio":
          switch($currentKat) {
            case "none":  include "./audio/index.php";     break;
            case "rec":   include "./audio/records.php";   break;
          }
        break;

        case "clipper":
          switch($currentKat) {
            case "none":
            case "sets":  include "./clipper/sets.php";    break;
            case "items": include "./clipper/items.php";   break;
            case "karte": include "./clipper/karte.php";   break;
          }
        break;

        case "linkliste":   include "./linkliste.php";   break;

        case "id3":
          switch($currentKat) {
            case "index":  include "./id3tags.php";   break;
          }
        break;

        case "login":
          if(isset($_SESSION['loggedIn']) && $_SESSION['loggedIn'] == "true") {
            include "./dashboard.php";
          } else {
            include "./login.php";
          }
        break;

        case "logout":   echo "LOGOUT";   break;
        case "fm":     include "fm.php";   break;
      }

    echo "</section>";

  ?></main>

  <footer>
    <div class="row">
      <div class="col-12 text-end">
        <p class="pp-inner"><small>&copy;</small> <u>pɑեʀ<span class="music-note">♪</span>ck|<span class="music-note">2c24</span></u></p>
      </div>
    </div>
  </footer>

  <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
<?php ob_flush(); ?>
