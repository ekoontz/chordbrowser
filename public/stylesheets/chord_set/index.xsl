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

  <xsl:template match="chord_sets">
    <xsl:apply-templates select="chord_set" mode="view_in_index"/>
  </xsl:template>

  <xsl:template match="chord_set" mode="view_in_index">
    <div style="float:left">
      <h2><a href="/chord_set/view/{@id}"><xsl:value-of select="@name"/></a></h2>
      <div class="chord_sets">
	<xsl:apply-templates select="chord_set"/>
      </div>

      <div style="float:left">
	<a href="/chords_set/new">add a new set</a>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/chord_sets" mode="menu">
    <xsl:choose>
      <xsl:when test="count(chord_set) = 1">
	<h2><a href="/">&doubleleft; All Sets</a></h2>
	<h2>Set: <xsl:value-of select="chord_set/@name"/></h2>
      </xsl:when>
      <xsl:otherwise>
	<h2><a href="/family/">&doubleleft; Families</a></h2>
	<h2>Sets</h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
