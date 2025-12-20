 <?php

  include_once("funktionen.php");

  $updatedata = new PfauDB();
  if(isset($_POST['update'])) {
    
    $_id   = intval($_GET['_id']);
    $name  = $_POST['name'];
    $image = $_POST['image'];
    $own   = $_POST['own'];
    $tags  = $_POST['tags'];
    $datum = $_POST['datum'];

    $sql = $updatedata->update($name, $image, $own, $tags, $datum, $_id);

    echo "<script>alert('Record Updated successfully');</script>";
    echo "<script>window.location.href='index.php'</script>";

  }

?><!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="utf-8">
  <title>PHP CURD Operation using  PHP OOP </title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body>

  <div class="container"><?php

    $_id = intval($_GET['_id']);
    $onerecord = new PfauDB();
    $sql = $onerecord->fetchonerecord($userid);
$cnt=1;
while($row=mysqli_fetch_array($sql))
  {
  ?>
<form name="insertrecord" method="post">
<div class="row">
<div class="col-md-4"><b>Name</b>
<input type="text" name="name" value="<?php echo htmlentities($row['name']);?>" class="form-control" required>
</div>
<div class="col-md-4"><b>Image</b>
<input type="text" name="image" value="<?php echo htmlentities($row['image']);?>" class="form-control" required>
</div>
</div>
<div class="row">
<div class="col-md-4"><b> Own</b>
<input type="text" name="own" value="<?php echo htmlentities($row['own']);?>" class="form-control" required>
</div>
<div class="col-md-4"><b>Contactno</b>
<input type="text" name="contactno" value="<?php echo htmlentities($row['ContactNumber']);?>" class="form-control" maxlength="10" required>
</div>
</div>
<div class="row">
<div class="col-md-8"><b>Datum</b>
<input type="date" class="form-control" name="datum" required /><?php echo htmlentities($row['datum']); ?>
</div>
</div>
<?php } ?>
<div class="row" style="margin-top:1%">
<div class="col-md-8">
<input type="submit" name="update" value="Update">
</div>
</div>
     </form>
            
      
	</div>
</div>

</body>
</html>