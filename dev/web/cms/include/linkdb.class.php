<?php

  class LinkDB {
	  
    // DATENBANK
    function __construct() {
      $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
      $this->dbc = $dbc;
      if(mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: ".mysqli_connect_error();
      }
    }
  
    // LiNKS
    public function insertLink($name, $icon, $kategorie, $url) {
      $insert_link = mysqli_query($this->dbc, "INSERT INTO data_links(name, icon, kategorie, url) VALUES('".$name."', '".$icon."', '".$kategorie."', '".$url."')");
      return $insert_link;
    }
	
    public function fetchLinks() {
  	  $links = mysqli_query($this->dbc, "SELECT * FROM data_links");
  	  return $links;
    }
    
    public function fetchLinksByKat($link_kat) {
  	  $links = mysqli_query($this->dbc, "SELECT * FROM data_links WHERE kategorie=".$link_kat." ORDER BY name, kategorie ASC");
  	  return $links;
    }
	
    public function fetchOneLink($link_id) {
  	  $one_link = mysqli_query($this->dbc, "SELECT * FROM data_links WHERE _id=".$link_id);
  	  return $one_link;
    }
	
    public function updateLink($name, $icon, $kategorie, $url, $_id) {
      $edit_link = mysqli_query($this->dbc, "UPDATE data_links set name='".$name."', icon='".$icon."', kategorie='".$kategorie."', url='".$url."' where _id='".$_id."'");
  	  return $edit_link;
  	}

    public function deleteLink($del_id) {
  	  $del_link = mysqli_query($this->dbc, "DELETE FROM data_links WHERE _id=".$del_id);
   	  return $del_link;
  	}

  }
  
?>
