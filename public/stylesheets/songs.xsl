<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="public/stylesheets/chordbrowser.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="songs" mode="menu">
    <h2><a href="/">&doubleleft; Families</a></h2>
    <h2><a href="/chord_set">&doubleleft; Sets</a></h2>
    <h2>Songs</h2>
  </xsl:template>

</xsl:stylesheet>

