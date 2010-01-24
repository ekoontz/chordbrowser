<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="/home/ekoontz/chordbrowser/public/stylesheets/chordbrowser.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="families">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="family">
    <div class="family">
      <h2><a href="/family/view/{@name}"><xsl:value-of select="@name"/></a></h2>
    </div>

  </xsl:template>

</xsl:stylesheet>
