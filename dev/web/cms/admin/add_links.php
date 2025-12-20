<?php

  require_once '../include/linkdb.class.php';

  $insert = new LinkDB();

  if(isset($_POST['sbmtInsert'])) {
    $name   = $_POST['name'];
    $icon   = $_POST['icon'];
    $kat    = $_POST['kategorie'];
    $subkat = $_POST['subkategorie'];
    $url    = $_POST['url'];

    $sql = $insert->insertLink($name, $icon, $kat, $subkat, $url);
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

      <div class="col-md-4"><b>Icon</b>
       <input type="text" name="icon" class="form-control" />
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>Kategorie</b>
        <select name="kategorie" class="form-control">
          <option>Google</option>
          <option>Dev</option>
          <option>RSS</option>
          <option>Audio</option>
          <option>XXX</option>
        </select>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>Subkategorie</b>
        <select name="subkategorie" class="form-control">
          <option>Link</option>
          <option>Bootstrap</option>
          <option>Github</option>
          <option>Grafiken</option>
          <option>scripte</option>
          <option>ressources</option>
          <option>snippets</option>
          <option>tutorials</option>
          <option>pix</option>
          <option>vid</option>
          <option>cam</option>
          <option>mag</option>
        </select>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4"><b>URL</b>
        <input type="text" name="url" class="form-control" required>
      </div>
    </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-8">
        <input type="submit" name="sbmtInsert" value="EiNTRAGEN">
      </div>
    </div> 
   
  </form>