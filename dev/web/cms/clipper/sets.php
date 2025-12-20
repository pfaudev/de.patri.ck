  <table><?php

    require "../include/clipperdb.class.php ";

    $dbc = new ClipperDB();
  	$res = mysqli_query($dbc, "SELECT * FROM clipper_sets");

    while($clpr = mysqli_fetch_object($res)) {
      echo "<tr scope='row'>";
      echo "<td scope='col'>".$clpr->_id."</td>";
      echo "<td scope='col'>".$clpr->name."</td>";
      echo "<td scope='col'>".$clpr->image."</td>";
      echo "<td scope='col'>".$clpr->own."</td>";
      echo "<td scope='col'>".$clpr->tags."</td>";
      echo "<td scope='col'>".$clpr->datum."</td>";

      echo "</tr>";
    }

  ?></table>
