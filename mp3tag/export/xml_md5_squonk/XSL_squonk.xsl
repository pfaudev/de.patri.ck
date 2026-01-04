<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*" />

<xsl:template match="/">
<html>
<head>
    <title><xsl:value-of select="name" /></title>
    <style>
    a {
		color:#000000;
		font-size:12px;
		font-family: Arial;
	}
    a.large {
		color:#ffffff; 
		background:#960000;
		font-size:18px;
		font-family: Arial;
	}
    a:link {
		color:#000000;
	}
    a.large:link {
		color:#ffffff;
	}
    a:visited {
		color:#444444;
	}
    a:active {
		color:#cc0000;
	}
    a:hover {
		color:#ffffff;
		background:#000000;
	}
    p {
		color: #000000;
		font-size:12px;
		font-family: Arial;
	}
    body {
		background: #ffffff;
		color: #000000;
	}
    h1 {
		font-size:18px;
		font-family: Arial;
		font-weight: bold;
		text-align: center;
	}
    th {
		text-align: left;
		font-size:12px;
		font-family: Arial;
		background: #960000;
		color: #ffffff;
	}
    th.large {
		text-align: center;
		vertical-align: middle;
		font-size:25px;
		font-family: Arial;
		font-weight: bold;
		background: #960000;
		color: #ffffff;
	}
    td {
		text-align: left;
		vertical-align: baseline;
		font-size:12px;
		font-family: Arial;
	}
    td.small {
		text-align: left;
		font-size:10px;
		font-family: Arial;
	}
    td.medium {
		text-align: left;
		font-size:16px;
		font-family: Arial;
	}
    td.image {
		text-align: center;
		vertical-align: middle;
		font-size:12px;
		font-family: Arial;
	}
    td.right {
		text-align: right;
	}
    .CDTitle {
		text-align: left;
		font-size:20px;
		font-weight: bold;
		font-family: Arial;
	}
    </style>
</head>
<body>
    <xsl:apply-templates />
</body>
</html>
</xsl:template>

<xsl:template match="MP3List">
	<center>
	<p>
		<table border="0" cellpadding="5" cellspacing="0" bgcolor="#f0c0a0" width="95%%">
		<tr><td>
			<table border="0" cellpadding="1" cellspacing="0" bgcolor="#960000" width="100%%">
			<tr><td bordercolor="#960000">
				<table border="0" cellpadding="3" cellspacing="1" bgcolor="#ffffff" width="100%%">
					<tr>
						<th class="large" width="100%%" colspan="2">
							<a class="large" href="Playlist.m3u"><xsl:value-of select="name" /></a>
						</th>
					</tr>
					<tr>
						<td class="right" width="50%%">
							<br/><b>Total tracks:</b><br/><b>Total Time:</b>
							<br/><b>Total size:</b><br/><b>File Created:</b><br/>
						</td>
						<td width="50%%">
							<br/>
							<xsl:value-of select="totalfiles" /><br/>
							<xsl:value-of select="totaltime" /><br/>
							<xsl:value-of select="totalsize" /><br/>
							<xsl:value-of select="datetime" /><br/>
						</td>
					</tr>
				</table>
			</td></tr></table>
		</td></tr></table>
	</p>
    <xsl:apply-templates select="artist" />
	<hr size="1" color="#f0c0a0" />
	<p>Created by <A HREF="http://www.mp3tag.de">
		<xsl:value-of select="app" /></A> (1999-2004, <A HREF="mailto:support@mp3tag.de">Florian Heidenreich</A>)<br/>
		Original Template Design from <b>www.cd2html.de</b>. This is a mod by <b>squonk</b>
	</p>
	</center>
</xsl:template>

<xsl:template match="artist">
	<p />
	
	<table border="0" cellpadding="5" cellspacing="0" bgcolor="#f0c0a0" width="95%%">
	<tr><td>
		<table border="0" cellpadding="1" cellspacing="0" bgcolor="#960000" width="100%%">
		<tr><td bordercolor="#960000">
			<table border="0" cellpadding="3" cellspacing="1" bgcolor="#ffffff" width="100%%">
				<tr>
					<th class="large" width="100%%">
						<xsl:value-of select="name" />
					</th>
				</tr>
			</table>
		</td></tr></table>
	</td></tr></table>

    <xsl:apply-templates select="album"/>
</xsl:template>

<xsl:template match="album">
<p>
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#f0c0a0" width="95%%">
<tr><td>
	<table border="0" cellpadding="1" cellspacing="0" bgcolor="#960000" width="100%%">
	<tr><td bordercolor="#960000">
		<table border="0" cellpadding="3" cellspacing="1" bgcolor="#ffffff" width="100%%">
			<tr><td class="image" width="28%%" bgcolor="#ffeec0">
				<img alt="Cover" width="200" height="200" border="0" bordercolor="#ffeec0">
				<xsl:attribute name="src"><xsl:value-of select="path" />cover.jpg</xsl:attribute>
				</img>
			</td>
			<td class="medium" width="72%%" bgcolor="#ffeec0">
				<xsl:value-of select="parent::artist/name" /><br/>
				<a class="CDTitle"><xsl:attribute name="href"><xsl:value-of select="path" />Playlist.m3u</xsl:attribute><xsl:value-of select="title" /></a>
				<table border="0" cellpadding="3" cellspacing="1" bgcolor="#ffeec0" width="100%%">
					<tr><td width="85%%" colspan="2">&#160;</td></tr>
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
					<tr><td width="85%%" colspan="2">&#160;</td></tr>
				</table>
			</td>
			</tr>
		</table>
		<table border="0" cellpadding="3" cellspacing="1" bgcolor="#ffffff" width="100%%">
			<th width="28%%">Filename</th>
			<th width="28%%">ID3-Details</th>
			<th width="28%%">mp3-Details</th>
			<th width="8%%">Duration</th>
			<th width="8%%">Filesize</th>
			<xsl:apply-templates select="track" />
		</table>
		</td></tr>
	</table>
</td></tr>
</table>
</p>
</xsl:template>

<xsl:template match="track">
    <xsl:choose>
		<xsl:when test="numtrack mod 2 = 1">
			<tr bgcolor="#ffeec0">
			<td>
				<a><xsl:attribute name="href"><xsl:value-of select="filename" /></xsl:attribute>
				<xsl:value-of select="numtrack" /> - <xsl:value-of select="title" />
				</a>
			</td>
			<td class="small">
				<xsl:value-of select="ancestor::artist/name" /><br/>
				<b><xsl:value-of select="title" /></b><br/>
				Album: <xsl:value-of select="parent::album/title" />
				<xsl:text>  (</xsl:text><xsl:value-of select="year" /><xsl:text>)</xsl:text><br/>
				Genre: <xsl:value-of select="genre" />
				<!-- Comment: %comment%<br> -->
			</td>
			<td class="small" width="160">
				<xsl:value-of select="codec" /> - <xsl:value-of select="bitrate" /> Kbit <xsl:value-of select="vbr" /><br/>
				<xsl:value-of select="mode" />, <xsl:value-of select="samplerate" /> Hz<br/>
				Tags: <xsl:value-of select="tags" /><br/>
				Tagsize: <xsl:value-of select="tagsize" /><br/>
			</td>
			<td>
				<xsl:value-of select="time" /> min
			</td>
			<td>
				<xsl:value-of select="size" />
			</td>
			</tr>
        </xsl:when>
        <xsl:otherwise>
			<tr bgcolor="#f0c0a0">
			<td>
				<a><xsl:attribute name="href"><xsl:value-of select="filename" /></xsl:attribute>
				<xsl:value-of select="numtrack" /> - <xsl:value-of select="title" />
				</a>
			</td>
			<td class="small">
				<xsl:value-of select="ancestor::artist/name" /><br/>
				<b><xsl:value-of select="title" /></b><br/>
				Album: <xsl:value-of select="parent::album/title" />
				<xsl:text>  (</xsl:text><xsl:value-of select="year" /><xsl:text>)</xsl:text><br/>
				Genre: <xsl:value-of select="genre" />
				<!-- Comment: %comment%<br> -->
			</td>
			<td class="small" width="160">
				<xsl:value-of select="codec" /> - <xsl:value-of select="bitrate" /> Kbit <xsl:value-of select="vbr" /><br/>
				<xsl:value-of select="mode" />, <xsl:value-of select="samplerate" /> Hz<br/>
				Tags: <xsl:value-of select="tags" /><br/>
				Tagsize: <xsl:value-of select="tagsize" /><br/>
			</td>
			<td>
				<xsl:value-of select="time" /> min
			</td>
			<td>
				<xsl:value-of select="size" />
			</td>
			</tr>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
