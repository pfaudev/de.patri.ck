<?php

  if(isset($_POST['sbmt'])) {

    $insert = new LinkDB();

    $name   = $_POST['name'];
    $icon   = $_POST['icon'];
    $kat    = $_POST['kategorie'];
    $subkat = $_POST['subkategorie'];
    $url    = $_POST['url'];

    $sql = $insert->insertLink($name, $icon, $kat, $subkat, $url); ?>
    
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labledby="modalLabel">
      <div class="modal-content">
        <div class="modal-header"></div>
        <div class="modal-body"></div>
        <div class="modal-footer"></div>
      </div>
    </div><?php

    if($sql) {
      $msg = "Record inserted successfully";
    } else {
      $msg = "Something went wrong!";
    }

  } else {

?>

  <form name="insert_link" method="POST">

    <div class="row" style="margin-top:1%">
      <div class="col-md-4"><input type="text" name="name" class="form-control" placeholder="NAME..." /></div>
    </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-4"><input type="text" name="image" class="form-control" placeholder="iMAGE..." /></div>
    </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-4">
        <label>Kategorie</label>
        <select name="kategorie" class="form-control">
          <option>Google</option>
          <option>Development</option>
          <option>RSS</option>
          <option>Audio</option>
          <option>XXX</option>
        </select>
      </div>
    </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-4">
        <label>Subkategorie</label>
        <select name="subkategorie" class="form-control">
        if(isset($kat)) { echo "<option>Link</option>"; }
        if($kat=="google") { echo "<option>Link</option>"; }
        if($kat=="rss") { echo "<option>Feed</option>";
        if($kat=="development") {
          echo "<option>Bootstrap</option>";
          echo "<option>Github</option>";
          echo "<option>Grafiken</option>";
          echo "<option>scripte</option>";
          echo "<option>ressources</option>";
          echo "<option>snippets</option>";
          echo "<option>tutorials</option>";
        }
        if($kat=="xxx") {
          echo "<option>pix</option>
          echo "<option>vid</option>
          echo "<option>cam</option>
          echo "<option>mag</option>
        }
        </select>
      </div>
    </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-4">
        <input type="text" name="url" class="form-control"></div>
      </div>

    <div class="row" style="margin-top:1%">
      <div class="col-md-8" style="width:calc(50% - 10px);">
        <input type="reset" name="reset" value="ABBRECHEN">
      </div>
      <div class="col-md-8" style="width:calc(50% - 10px);">
        <input type="submit" name="sbmt" value="EiNTRAGEN">
      </div>
    </div> 
   
  </form>

<?php } ?>