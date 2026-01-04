<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*" />

<xsl:template match="/">
<html>
<head>
    <title><xsl:value-of select="name" /></title>
    <style>
    th {
		font-size:14px;
		font-family: Arial;
		text-align: left;
		background: #848484;
		color: #ffffff;
	}
    td {
		font-size:14px;
		font-family: Arial;
		text-align: left;
	}
	body {
		font-size:14px;
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
	<h1>List of albums in <xsl:value-of select="name" /></h1>
	
    <xsl:apply-templates select="artist" />
	
	<hr size="1" color="#0" />
	<center>
	<p>Created by <A HREF="http://www.mp3tag.de">
		<xsl:value-of select="app" /></A> (1999-2004, <A HREF="mailto:support@mp3tag.de">Florian Heidenreich</A>)<br/>
		Template Design by <b>squonk</b>
	</p>
	</center>
</xsl:template>

<xsl:template match="artist">
	<hr size="1" color="#0" />
	<h2> <xsl:value-of select="name" /></h2>
	<h4>
		<xsl:value-of select="files" /> files (<xsl:value-of select="size" />)<br />
		<xsl:value-of select="time" />
	</h4>
	<hr size="1" color="#0" />
    <xsl:apply-templates select="album"/>
</xsl:template>

<xsl:template match="album">
<p>
<h3><xsl:value-of select="title" /> (<xsl:value-of select="year" />)</h3>
	<h4>
		<xsl:value-of select="files" /> files (<xsl:value-of select="size" />)<br />
		<xsl:value-of select="time" />
	</h4>
	<table width="90%%">
		<th width="10%%">#</th>
		<th width="50%%">Filename</th>
		<th width="20%%">Duration</th>
		<th width="20%%">Filesize</th>
	
		<xsl:apply-templates select="track" />
	</table>
</p>
</xsl:template>

<xsl:template match="track">
    <xsl:choose>
		<xsl:when test="numtrack mod 2 = 1">
			<tr bgcolor="#cccccc">
				<td>
					<xsl:value-of select="numtrack" />
				</td>
				<td class="small">
					<xsl:value-of select="title" />
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
			<tr>
				<td>
					<xsl:value-of select="numtrack" />
				</td>
				<td class="small">
					<xsl:value-of select="title" />
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
