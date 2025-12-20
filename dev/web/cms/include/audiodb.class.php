<?php

  class AudioDB {

	// DATENBANK
    function __construct() {
      $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
      $this->dbc = $dbc;
      if(mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: ".mysqli_connect_error();
      }
    }

    // AUFNAHMEN
    public function insertRecord($artist, $title, $cover, $tracklist, $datum) {
      $ret = mysqli_query($this->dbc, "INSERT INTO audio_records(artist, title, cover, tracklist, datum) VALUES('".$artist."', '".$title."', '".$cover."', '".$tracklist."', '".$datum."')");
      return $ret;
    }

    public function fetchRecords() {
  	  $ret = mysqli_query($this->dbc, "SELECT * FROM audio_records");
  	  return $ret;
    }

    public function fetchOneRecord($rec_id) {
  	  $ret = mysqli_query($this->dbc, "SELECT * FROM audio_records WHERE _id=".$rec_id);
  	  return $ret;
    }

    public function updateRecord($rec_id, $artist, $title, $cover, $tracklist, $datum) {
      $ret = mysqli_query($this->dbc, "UPDATE audio_records set artist='".$artist."', title='".$title."', cover='".$cover."', tracklist='".$tracklist."', datum='".$datum."' where _id='".$rec_id."'");
  	  return $ret;
  	}

    public function deleteRecord($rec_id) {
  	  $ret = mysqli_query($this->dbc, "DELETE FROM audio_records WHERE _id=".$rec_id);
   	  return $ret;
  	}

  }
  
?>