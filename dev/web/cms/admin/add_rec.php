<?php

  require_once '../include/audiodb.class.php';

  $insert_rec = new AudioDB();

  if(isset($_POST['sbmtInsert'])) {

    $artist    = $_POST['artist'];
    $title     = $_POST['title'];
    $cover     = $_POST['cover'];
    $tracklist = $_POST['tracklist'];
    $datum     = $_POST['datum'];

    $sql = $insert_rec->insert($artist, $title, $cover, $tracklist, $datum);
    if($sql) {
      echo "<script>alert('Record inserted successfully');</script>";
      echo "<script>window.location.href='index.php'</script>";
    } else {
      echo "<script>alert('Something went wrong. Please try again');</script>";
      echo "<script>window.location.href='index.php'</script>";
    }

  }

?>

  <form name="insertrecord" method="post">

    <div class="row">
      <div class="col-md-4"><b>Artist</b>
        <input type="text" name="name" class="form-control" required>
      </div>
      <div class="col-md-4"><b>Cover</b>
       <input type="text" name="image" class="form-control" required>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>Tracklist</b>
        <textarea name="tracklist" class="form-control"></textarea>
      </div>
    </div>

    <div class="row">
      <div class="col-md-8">
        <b>Datum</b>
        <input type="date" class="form-control" name="datum" required />
      </div>
    </div>  

    <div class="row" style="margin-top:1%">
      <div class="col-md-8">
        <input type="submit" name="sbmtInsert" value="EiNTRAGEN">
      </div>
    </div> 
   
  </form>