<?php

  require_once'funktionen.php';

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

?><!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="utf-8">
  <title>CRUDOOP</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body>

  <header>
    <div class="container-fluid">
      <div class="row">
        <a href="add.php"><button class="btn btn-primary">ADD</button></a>
      </div>
    </div>
  </header>

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

</body>
</html>