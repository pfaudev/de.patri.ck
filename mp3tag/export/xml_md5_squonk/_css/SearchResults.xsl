<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/Tracks">
<table width="520px" cellspacing="10" >
	<tr>
		<td valign="top" >
			<ul class="bulletlist">
				<xsl:apply-templates select="track"/>
			</ul>
		</td>
	</tr>
</table>

</xsl:template>

<xsl:template match="track">
	<xsl:if test="position() > 1">
		<br />
	</xsl:if>
	<li>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="filename" /></xsl:attribute>
			<xsl:value-of select="numtrack" /> - <xsl:value-of select="title" />
		</a>
	</li>

	<br />

	<table style="width: 500;">
		<tr>
			<td style="width: 100">
				<b>Time:  </b><xsl:value-of select="time" />
			</td>
			<td>
				<b>Size:  </b><xsl:value-of select="size" />
			</td>
		</tr>
		<tr>
			<td style="width: 100">
				<b>Artist:</b>
			</td>
			<td>
				<xsl:value-of select="artist" />
			</td>
		</tr>
		<tr>
			<td style="width: 100">
				<b>Album:</b>
			</td>
			<td>
				<a><xsl:attribute name="href">
						<xsl:value-of select="FilenamePath" /><xsl:value-of select="album" />.m3u
					</xsl:attribute>
					<xsl:value-of select="album" />
				</a>
			</td>
		</tr>
	</table>

	<xsl:if test="position() != last()">
		<hr size="1" color="#EECDA3" />
	</xsl:if>

</xsl:template>


</xsl:stylesheet>
