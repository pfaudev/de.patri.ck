<?php

  class ClipperDB {
	  
    // DATENBANK
    function __construct() {
      $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
      $this->dbc = $dbc;
      if(mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: ".mysqli_connect_error();
      }
    }
  
    // SETS
    public function insertSet($name, $image, $own, $tags, $datum) {
      $ret = mysqli_query($this->dbc, "INSERT INTO clipper_sets(name, image, own, tags, datum) VALUES('".$name."', '".$image."', '".$own."', '".$tags."', '".$datum."')");
      return $ret;
    }
	
    public function fetchSets() {
  	  $res = mysqli_query($this->dbc, "SELECT * FROM clipper_sets");
  	  return $res;
    }
	
    public function fetchOneSet($_id) {
  	  $one_res = mysqli_query($this->dbc, "SELECT * FROM clipper_sets WHERE _id=".$_id);
  	  return $one_res;
    }
	
    public function updateSet($name, $image, $own, $tags, $datum, $_id) {
      $update_record = mysqli_query($this->dbc, "UPDATE clipper_sets set name='".$name."', image='".$image."', own='".$own."', tags='".$tags."', datum='".$datum."' where _id='".$_id."'");
  	  return $update_record;
  	}

    public function deleteSet($del_id) {
  	  $del_record = mysqli_query($this->dbc, "DELETE FROM clipper_sets WHERE _id=".$del_id);
   	  return $del_record;
  	}

    // iTEMS
    public function insertItem($name, $image, $own, $tags, $datum) {
      $ret = mysqli_query($this->dbc, "INSERT INTO clipper_sets(name, image, own, tags, datum) VALUES('".$name."', '".$image."', '".$own."', '".$tags."', '".$datum."')");
      return $ret;
    }
	
    public function fetchItems() {
  	  $res = mysqli_query($this->dbc, "SELECT * FROM clipper_sets");
  	  return $res;
    }
	
    public function fetchOneItem($_id) {
  	  $one_res = mysqli_query($this->dbc, "SELECT * FROM clipper_sets WHERE _id=".$_id);
  	  return $one_res;
    }
	
    public function updateItem($name, $image, $own, $tags, $datum, $_id) {
      $update_record = mysqli_query($this->dbc, "UPDATE clipper_sets set name='".$name."', image='".$image."', own='".$own."', tags='".$tags."', datum='".$datum."' where _id='".$_id."'");
  	  return $update_record;
  	}

    public function deleteItem($del_id) {
  	  $del_record = mysqli_query($this->dbc, "DELETE FROM clipper_sets WHERE _id=".$del_id);
   	  return $del_record;
  	}

  }
  
?>