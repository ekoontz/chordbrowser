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

  <xsl:template match="families">
    <xsl:apply-templates select="family" mode="view_in_index"/>
  </xsl:template>

  <xsl:template match="family" mode="view_in_index">
    <div style="float:left">
      <h2><a href="/family/view/{@id}"><xsl:value-of select="@name"/></a></h2>
      <div class="family">
	<div class="chords">
	  <xsl:apply-templates select="chord"/>
	</div>
	<div style="float:left">
	  <a href="/family/newchord/{@id}">add a new chord to this family</a>
	</div>

      </div>
    </div>
  </xsl:template>

  <xsl:template match="/families" mode="menu">
    <xsl:choose>
      <xsl:when test="count(family) = 1">
	<h2><a href="/">&doubleleft; Families</a></h2>
	<h2>Family: <xsl:value-of select="family/@name"/></h2>
      </xsl:when>
      <xsl:otherwise>
	<h2>Families</h2>
	<h2><a href="/chord_set/">Sets</a></h2>
      </xsl:otherwise>
    </xsl:choose>
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
