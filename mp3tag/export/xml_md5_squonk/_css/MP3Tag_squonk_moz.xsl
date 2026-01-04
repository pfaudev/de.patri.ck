<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*" />
<xsl:output method="html"/>

<xsl:template match="/">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="MP3List">
	<div id="wrap">
		<div id="banner">
			<table cellpadding="0" cellspacing="0" width="100%%">
			<tr>
			<td height="68px" width="56px" background="_images/logo4.gif" id="logo" style="cursor: pointer;" onclick="show_logo();"></td>
			<td height="68px" background="_images/tile_back.gif" >
				<table cellpadding="0" cellspacing="0" width="100%%" border="0">
					<tr>
						<td height="42px" valign="bottom" colspan="4" >
							<a class="large" margin-left="20" href="Playlist.m3u"><xsl:value-of select="name" /></a>
						</td>
					</tr>
					<tr height="26px">
						<td id="spacer" width="432"></td>
					<!-- Search Form -->
						<td align="center">
							<select id="search_options" name="select">
								<option value="song" selected="true">Song</option>
								<option value="artist" >Artist</option>
								<option value="album">Album</option>
							</select>
						</td>
						<td align="center">
							<input maxlength="150" size="25" id="search_txt" />
						</td>
						<td align="center">
							<input type="button" value="Find" name="btnFind" onclick="return search();" />
						</td>
					</tr>
				</table>
			</td>
			</tr>
			</table>
		</div>
		<div class="content">
			<div id="ArtistName" >
				<h1>&#160;<xsl:value-of select="/MP3List/artist[1]/name" /></h1><br/>
			</div>
			<table border="0" cellpadding="0"><tr>
			<td style="vertical-align: top;" >
			<div id="CDData" style="min-height: 450; width: 553;"  >
				<xsl:apply-templates select="/MP3List/artist[1]/album[1]" />
			</div>
			</td>
			<td style="vertical-align: top;">
			<div class="news" STYLE="overflow: auto; flow: right; height: 450" >
				<xsl:apply-templates select="artist" mode="news" />
				<br/>
			</div>
			</td>
			</tr></table>
		
		</div>
	</div>
	<p>
	<div id="footer">
		<p>
			<a href="http://www.mp3tag.de" title="MP3Tag">
			<img src="_images/mp3tag.png" alt="MP3Tag" /></a>
		</p>
		<p>Created by <A HREF="http://www.mp3tag.de">
			<xsl:value-of select="app" /></A> (1999-2004, <b>Florian Heidenreich</b>)<br/>
			Original Template Design from <A HREF="http://www.mp3tag.de">www.mp3tag.de</A> site design. This is a mod by <b>squonk</b>
		</p>
	</div>
	</p>
</xsl:template>


<xsl:template match="artist">
	<h1>&#160;<xsl:value-of select="name" /></h1>
	
	<br/>

	<xsl:apply-templates select="album"/>
</xsl:template>

<xsl:template match="artist" mode="news" >

	<h3><xsl:value-of select="name" /></h3>

	<xsl:apply-templates select="album" mode="news" />

	<xsl:if test="position() != last()">
		<hr size="1" color="#EECDA3" />
	</xsl:if>
</xsl:template>

<xsl:template match="album" mode="news" >
	<div id="AlbumRow" onMouseOver="javascript: return HL( this, true );" onMouseOut="javascript: return HL( this, false );">
	<xsl:attribute name="onClick">javascript:changeCD(&quot;<xsl:value-of select="track/md5" />&quot;);</xsl:attribute>
		<table width="100%" >
			<tr>
				<td width="54">
					<img class="imgcenter" width="50" height="50" border="0" style="float: left;" >
						<xsl:attribute name="src"><xsl:value-of select="path" />cover.jpg</xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="../name" /> - [<xsl:value-of select="year" />] <xsl:value-of select="title" /></xsl:attribute>
					</img>
				</td>
				<td padding="2px" class="AlbumRow">
					[<xsl:value-of select="year" />]<br/><xsl:value-of select="title" />
				</td>
			</tr>
		</table>
	</div>
</xsl:template>

<xsl:template match="album">
	<br/>
	<div class="topic">&#160;<xsl:value-of select="title" /></div>
	<table cellspacing="10">
	<tr>
		<td class="CD" align="center" valign="top" width="200px" >
			<table border="0" bordercolor="#000000" width="100%%">
				<tr>
					<td width="85%%" colspan="2">
						<a>
							<xsl:attribute name="href"><xsl:value-of select="path" /><xsl:value-of select="title" />.m3u</xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="title" /></xsl:attribute>
							<img class="preview" alt="Cover" width="190" height="190" border="0" bordercolor="#000000">
								<xsl:attribute name="src"><xsl:value-of select="path" />cover.jpg</xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td width="15%%"><b>Year:</b><br/><b>Genre:</b></td>
					<td width="70%%">
						<xsl:value-of select="year" /><br/><xsl:value-of select="genre" />
					</td>
				</tr>
				<tr>
					<td width="15%%">
						<b>Tracks:</b><br/>
						<b>Time:</b><br/>
						<b>Size:</b>
					</td>
					<td width="70%%">
						<xsl:value-of select="files" /><br/>
						<xsl:value-of select="time" /><br/>
						<xsl:value-of select="size" />
					</td>
				</tr>
				<tr>
					<td width="15%%">
						<b>Codec:</b><br/>
						<b>Bitrate:</b><br/>
						<b>Mode:</b>
					</td>
					<td width="70%%">
						<xsl:value-of select="child::track/codec" /><br/>
						<xsl:value-of select="child::track/bitrate" /> Kb 
						<xsl:value-of select="child::track/vbr" /><br/>
						<xsl:value-of select="child::track/mode" />, 
						<xsl:value-of select="child::track/samplerate" /> Hz
					</td>
				</tr>
				<tr>
					<td width="15%%">
					<b>Tags:</b>
					</td>
					<td width="70%%">
						<xsl:value-of select="child::track/tags" />
					</td>
				</tr>
				<tr><td width="85%%" colspan="2">&#160;</td></tr>
			</table>
		</td>
		<td valign="top" width="347px" >
			<ul class="bulletlist">
				<xsl:apply-templates select="track"/>
			</ul>
		</td>
	</tr>
	</table>

</xsl:template>


<xsl:template match="track">

<li>
	<a>
		<xsl:attribute name="href"><xsl:value-of select="filename" /></xsl:attribute>
		<xsl:value-of select="numtrack" /> - <xsl:value-of select="title" />
	</a>

	<table width="100%">
	<tr>
		<td>
			<b>Time:  </b><xsl:value-of select="time" />
		</td>
		<td>
			<b>Size:  </b><xsl:value-of select="size" />
		</td>

		<td width="100"/>
	</tr>
	</table>
	<br/>
</li>

</xsl:template>

</xsl:stylesheet>

