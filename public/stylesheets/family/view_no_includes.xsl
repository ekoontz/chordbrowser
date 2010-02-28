<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:param name="action"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="family" mode="menu">
    <h2><a href="/chord_set">&doubleleft; Sets</a></h2>
    <h2><a href="/">&doubleleft; Families</a></h2>
    <h2>Family: <xsl:value-of select="@name"/></h2>
  </xsl:template>

  <xsl:template match="*" mode="menu">
  </xsl:template>

  <xsl:template match="chord_attributes" mode="checkboxes">
    <div>
      <xsl:apply-templates mode="checkbox"/>
    </div>
  </xsl:template>

  <xsl:template match="chord_attribute" mode="checkbox">
    <label for="attr_{@name}"><xsl:value-of select="@name"/></label>
    <input id="attr_{@name}" type="checkbox" name="attrib[{@name}]"/>
  </xsl:template>

</xsl:stylesheet>
