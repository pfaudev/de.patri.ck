<?php

  require_once '../include/clipperdb.class.php';

  $insert_data = new PfauDB();

  if(isset($_POST['insert'])) {
    $name  = $_POST['name'];
    $image = $_POST['image'];
    $own   = $_POST['own'];
    $tags  = $_POST['tags'];
    $datum = $_POST['datum'];

    $sql = $insert_data->insert($name, $image, $own, $tags, $datum);
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
      <div class="col-md-4"><b>Name</b>
        <input type="text" name="name" class="form-control" required>
      </div>
      <div class="col-md-4"><b>Image</b>
       <input type="text" name="image" class="form-control" required>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>Own</b>
        <input type="radio" name="own" class="form-control" value="0" /> Nein
        <input type="radio" name="own" class="form-control" value="1" /> Ja
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>Tags</b>
        <input type="text" name="image" class="form-control" required>
      </div>
    </div>

    <div class="row">
      <div class="col-md-8">
        <b>Datum</b>
        <textarea class="form-control" name="datum" required></textarea>
      </div>
    </div>  

    <div class="row" style="margin-top:1%">
      <div class="col-md-8">
        <input type="submit" name="insert" value="EiNTRAGEN">
      </div>
    </div> 
   
  </form>