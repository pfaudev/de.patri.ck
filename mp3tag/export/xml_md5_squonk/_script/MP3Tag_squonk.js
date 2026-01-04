function HL(element, on) 
{
	if (!on)
	{ 
		element.style.backgroundColor = '#ffffe1';
		element.style.borderColor = '#ffffe1';
		element.style.cursor = 'auto';
	} else { 
		element.style.backgroundColor = '#EECDA3';
		element.style.borderColor = '#960000';
		element.style.cursor = 'pointer';
	}

	return false;
}

function changeCD(title) {

	var CDDataDiv = document.getElementById('CDData');
	Sarissa.clearChildNodes(CDDataDiv);

	try {
		var n = xmlData.selectSingleNode("/MP3List/artist/album/track[md5='" + title +"']/../../name");
		var x = xmlData.selectSingleNode("/MP3List/artist/album[track/md5='" + title +"']");
	
		var sArtistName;
	
		if(_SARISSA_IS_IE)
		{
			var parser = new DOMParser();
			var xmltemp = parser.parseFromString(Sarissa.serialize(x), "text/xml");
			
			Sarissa.updateContentFromNode(xmltemp, CDDataDiv, xsltProc);
	
			sArtistName = n.text;
		}
		else
		{
			var fragment = xsltProc.transformToFragment(x, document);
			CDDataDiv.appendChild(fragment);
	
			sArtistName = n.textContent;
		}
	
		// Display Artist name
		var ArtistName = document.getElementById('ArtistName');
		ArtistName.innerHTML = "<h1>&#160;" + sArtistName + "</h1><br/>";
	}catch(e){
		CDDataDiv.innerHTML = "Error searchin' XML:<br/>" + e;
		return false;
	};
}

function _search(mode, txt) {

	var sCriteria = "";
	var sTitle = "Tracks ";
	
	switch(mode)
	{	
	case 'artist':
		sCriteria = "../../name";
		sTitle = sTitle + "by Artist with name containing <i>'" + txt + "'</i>";
		break;
	case 'album':
		sCriteria = "../title";
		sTitle = sTitle + "in Album with title containing <i>'" + txt + "'</i>";
		break;
	case 'song':
		sCriteria = "title";
		sTitle = sTitle + " with title containing <i>'" + txt + "'</i>";
		break;
	}

	var sQuery = "/MP3List/artist/album/track[contains(translate(" + sCriteria;
	sQuery = sQuery + ", 'ABCDEFGHIJKLMNOPQRSTUVWXYZ¡…Õ”⁄¿»Ã“ŸƒÀœ÷‹¬ Œ‘€—«’–ÿ›ü∆√≈ﬂUU', ";
	sQuery = sQuery + "'abcdefghijklmnopqrstuvwxyz·ÈÌÛ˙‡ËÏÚ˘‰ÎÔˆ¸‚ÍÓÙ˚ÒÁı¯˝ˇÊ„Âﬂuu'), '";
	sQuery = sQuery + txt + "')]";
	
	var artistNameDiv = document.getElementById('ArtistName');
	artistNameDiv.innerHTML = '<h1>&#160;Search Results</h1><br/>';
	
	var tracks = xmlData.selectNodes(sQuery);
	var sTracks = "<Tracks>";

	for(var i=0; i < tracks.length; i++) 
	{
		sTracks += Sarissa.serialize(tracks[i]);
	};

	sTracks += "</Tracks>";

	var parser = new DOMParser();
	var xmltemp = parser.parseFromString(sTracks, "text/xml");

	var stylesheet = Sarissa.getDomDocument();
	stylesheet.async = false;
	stylesheet.load('_css/SearchResults.xsl');
	
	var processor = new XSLTProcessor();
	processor.importStylesheet(stylesheet);

	var CDDataDiv = document.getElementById('CDData');
	Sarissa.clearChildNodes(CDDataDiv);

	if(!_SARISSA_IS_IE)
	{
		var fragment = processor.transformToFragment(xmltemp, document);
		CDDataDiv.appendChild(fragment);
	}
	else
	{
		Sarissa.updateContentFromNode(xmltemp, CDDataDiv, processor);
	}
}

function search() {
	var searchOptions = document.getElementById('search_options');
	var searchTxt = document.getElementById('search_txt');

	_search(searchOptions.value, searchTxt.value.toLowerCase());
}

function show_logo() {
	var oSpacer = document.getElementById("spacer");
	var oLogo = document.getElementById("logo");
	
	oSpacer.width = ((oLogo.width == 56) ? 236: 432);
	oLogo.width = ((oLogo.width == 56) ? 252 : 56);
}

