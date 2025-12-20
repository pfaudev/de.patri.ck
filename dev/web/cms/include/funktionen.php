<?php

  function cleanInput($dirty) {
    $tmp = strip_tags($dirty);
    $tmp = stripslashes($tmp);
    $tmp = html_entity_decode($tmp, ENT_QUOTES, 'UTF-8');
    $clean = trim($tmp);
    return $clean;
  }

  function getAcoustID($duration, $fingerprint) {
    if(preg_match_all('/(?:"id": ")(.*?)(?:", ")/', file_get_contents("https://api.acoustid.org/v2/lookup?client=pRScNQrNxy&duration=".$duration."&fingerprint=".$fingerprint), $match, PREG_SET_ORDER, 0)) {
	  return $match[0][1];
	} else {
	  return "Kein Eintrag!";
	}
  }

  function formatUmlaute($in) {
    $out = str_replace("ä", "&auml;", $in);
    $out = str_replace("ö", "&ouml;", $out);
    $out = str_replace("ü", "&uuml;", $out);
    $out = str_replace("ß", "ss", $out);
    return $out;
  }

  function formatLetters($in) {
    $out = str_replace("ė", "e", $in);
    $out = str_replace("ė", "e", $out);
    $out = str_replace("ê", "e", $out);
    $out = str_replace("ë", "e", $out);
    $out = str_replace("è", "e", $out);
    $out = str_replace("é", "e", $out);
    $out = str_replace("æ", "ae",$out);
    $out = str_replace("ã", "a", $out);
    $out = str_replace("å", "a", $out);
    $out = str_replace("ā", "a", $out);
    $out = str_replace("â", "a", $out);
    $out = str_replace("à", "a", $out);
    $out = str_replace("á", "a", $out);
    $out = str_replace("ō", "a", $out);
    $out = str_replace("ø", "a", $out);
    $out = str_replace("œ", "a", $out);
    $out = str_replace("õ", "a", $out);
    $out = str_replace("ô", "a", $out);
    $out = str_replace("ò", "a", $out);
    $out = str_replace("ó", "a", $out);
    return $out;
  }

  function formatArtist($artist) {
    $artist = formatUmlaute($artist);
    $artist = formatLetters($artist);

    return $artist;
  }

  function switchKeys($key) {
    $key = strtolower(trim($key));
    switch($key) {
	  case "a":	  case "4d":   case "11b":   case "amaj":	  
	    echo "<b>A-Major</b> // <b>A-Dur</b><br />";
	    echo "<hr />";
	    echo "KEY: <b>A</b><br />";
	    echo "OPENKEY: <b>4d</b><br />";
	    echo "CAMELOT: <b>11B</b>";
	  break;
      case "as-dur":   case "ab":   case "9d":   case "4b":   case "abmaj":   case "a♭":
	  case "a♭maj":   case "g#":   case "g#maj":   case "g♯":   case "g♯maj":
	    echo "<div class='row'>";		
	    echo "<div class='lbl'>NAME:</div><div class='val'>As-Dur</div><br />";
	    echo "<div class='lbl'>MUSiCKEY:</div><div class='val'>Ab</div><br />";
	    echo "<div class='lbl'>OPENKEY:</div><div class='val'>9d</div><br />";
	    echo "<div class='lbl'>CAMELOT:</div><div class='val'>4B</div><br />";
	    echo "<div class='lbl'>MUSiCKEY EXT:</div><div class='val'>Abmaj</div><br />";
	    echo "<div class='lbl'>ALL SHARPS:</div><div class='val'>G#</div><br />";
	    echo "<div class='lbl'>ALL SHARPS EXT:</div><div class='val'>G#maj</div><br />";
	    echo "<div class='lbl'>WESTERNMUSICSCALE:</div><div class='val'>A-FlatMajor</div>";
		echo "<div>";
	  break;
	  case "a-moll":   case "am":   case "1m":   case "8a":
	  case "amin":   case "am":   case "amin":   case "a minor":
	    echo "<div class='row'>";		
	    echo "<div class='lbl'>NAME:</div><div class='val'>a-Moll</div>";
	    echo "<div class='lbl'>MUSiCKEY:</div><div class='val'>Am</div>";
	    echo "<div class='lbl'>OPENKEY:</div><div class='val'>1m</div>";
	    echo "<div class='lbl'>CAMELOT:</div><div class='val'>8A</div>";
	    echo "<div class='lbl'>MUSiCKEY EXT:</div><div class='val'>Amin</div>";
	    echo "<div class='lbl'>ALL SHARPS:</div><div class='val'>Am</div>";
	    echo "<div class='lbl'>ALL SHARPS EXT:</div><div class='val'>Amin</div>";
	    echo "<div class='lbl'>WESTERNMUSICSCALE:</div><div class='val'>AMinor</div>";
		echo "<div>";
	  break;
      case "h-dur":   case "♭":   case "6d":   case "1b":   case "♭maj":
	  case "b":   case "bmaj":   case "bmajor":   case "♭major":
	    echo "<div class='row'>";		
	    echo "<div class='lbl'>NAME:</div><div class='val'>h-Dur</div>";
	    echo "<div class='lbl'>MUSiCKEY:</div><div class='val'>B</div>";
	    echo "<div class='lbl'>OPENKEY:</div><div class='val'>6d</div>";
	    echo "<div class='lbl'>CAMELOT:</div><div class='val'>1B</div>";
	    echo "<div class='lbl'>MUSiCKEY EXT:</div><div class='val'>Bmaj</div>";
	    echo "<div class='lbl'>ALL SHARPS:</div><div class='val'>B</div>";
	    echo "<div class='lbl'>ALL SHARPS EXT:</div><div class='val'>Bmaj</div>";
	    echo "<div class='lbl'>WESTERNMUSICSCALE:</div><div class='val'>BMajor</div>";
		echo "<div>";
	  break;
	  case "b-Dur":   case "Bb":   case "11d":   case "6B":   case "Bbmaj":   case "A#":
	  case "A#maj":   case "B-Flat Major":   case "B♭":   case "B♭maj":   case "A♯":   case "A♯maj":
	    echo "<div class='row'>";		
	    echo "<div class='lbl'>NAME:</div><div class='val'>b-Dur</div>";
	    echo "<div class='lbl'>MUSiCKEY:</div><div class='val'>Bb</div>";
	    echo "<div class='lbl'>OPENKEY:</div><div class='val'>11d</div>";
	    echo "<div class='lbl'>CAMELOT:</div><div class='val'>6B</div>";
	    echo "<div class='lbl'>MUSiCKEY EXT:</div><div class='val'>Bbmaj</div>";
	    echo "<div class='lbl'>ALL SHARPS:</div><div class='val'>A#</div>";
	    echo "<div class='lbl'>ALL SHARPS EXT:</div><div class='val'>A#maj</div>";
	    echo "<div class='lbl'>WESTERNMUSICSCALE:</div><div class='val'>B-FlatMajor</div>";
		echo "<div>";
	  break;
	  case "a#m":
	  case "bm":
	  case "c":
	  case "c#m":
	  case"cm":
	  case"d":
	  case "c#":
	  case"dm":	  
	  case"e":
	  case "d#":
	  case "d#m":
	  case"em":
	  case"f":
	  case "f#m":  
	  case"fm":
	  case"g":
	  case "g#m":
	  case "f#":
	  case"gm":
    }
    return;
  }

?>