<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="public/stylesheets/chordbrowser.xsl"/>
  <xsl:include href="public/stylesheets/chord_set/lib.xsl"/>

  <xsl:template match="chord_sets">
    <xsl:apply-templates select="." mode="view_in_index"/>
    <xsl:if test="$current_user">
      <div style="float:left">
	<a href="/chord_set/new">add a new set</a>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/chord_sets" mode="menu">
    <h2><a href="/family/">&doubleleft; Families</a></h2>
    <h2>Sets</h2>
  </xsl:template>

</xsl:stylesheet>
