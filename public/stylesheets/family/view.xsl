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

  <xsl:template match="family">
    <xsl:apply-templates select="." mode="view"/>
  </xsl:template>

  <xsl:template match="family" mode="view">
    <xsl:apply-templates/>
    <div style="float:left">
      <a href="/family/newchord/{@id}">add a new chord to this family</a>
    </div>

  </xsl:template>

</xsl:stylesheet>
