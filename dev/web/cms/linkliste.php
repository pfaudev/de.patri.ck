<?php

  include_once "./include/linkdb.class.php";

  if(isset($_GET['do']) && $_GET['do']=="del") {
    $del_id = $_GET['id'];
    $del_data = new LinkDB();
    $sql0 = $del_data->deleteLink($del_id);
    if($sql0) {		
      echo "<script>alert('Eintrag erfolgreich entfernt!');</script>";
      echo "<script>window.location.href='./index.php'</script>";
    }
  }

?><div class="row">

  <div class="col-md-12">
    <div class="table-responsive"><?php
    
      $data = new LinkDB();
      $sql = $data->fetchLinksByKat('google');
      
      while($r = mysqli_fetch_array($sql)) {
        echo "<table id='mytable' class='table table-bordred table-striped table-hovered'>";
        echo "<thead><th>".htmlentities(strtoupper($r['kategorie']))."</th></thead>";
        echo "<tbody><tr><td><a href='".htmlentities($r['url'])."' target='_blank'>".htmlentities($r['name'])."</a></td></tr></tbody>";
        echo "</table>";
      }
    ?></div>
  </div>

</div>
