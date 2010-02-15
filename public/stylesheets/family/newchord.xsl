<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="public/stylesheets/chordbrowser.xsl"/>
  <xsl:include href="public/stylesheets/chord.xsl"/>
  <xsl:include href="public/stylesheets/family/view_no_includes.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
 </xsl:template>

  <xsl:template match="families" mode="menu">
    WTF: <xsl:value-of select="$action"/>
    <xsl:apply-templates mode="menu"/>
  </xsl:template>

  <xsl:template match="edit/chord/fret/@*" mode="nut">
    <select name="fret[nut][{name()}]]">
      <option/>
      <option>
	<xsl:if test=". = 'x'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>x</option>
      <option value="open">
	<xsl:if test=". = 'open'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>o</option>
    </select>
  </xsl:template>

  <xsl:template match="edit/chord/fret/@*" mode="fret">
    <select name="fret[{../@number}][{name()}]">
      <option/>
      <option>1</option>
      <option>2</option>
      <option>3</option>
      <option>4</option>
    </select>
  </xsl:template>

</xsl:stylesheet>
