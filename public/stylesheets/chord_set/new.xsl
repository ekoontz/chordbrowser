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

  <xsl:template match="chord_sets" mode="menu">
    <xsl:choose>
      <xsl:when test="count(chord_set) = 1">
	<h2><a href="/">&doubleleft; All Sets</a></h2>
	<h2>Set: <xsl:value-of select="chord_set/@name"/></h2>
      </xsl:when>
      <xsl:otherwise>
	<h2><a href="/family/">&doubleleft; Families</a></h2>
	<h2><a href="/chord_set">&doubleleft; Sets</a></h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="chord_sets">
    <xsl:apply-templates select="." mode="view_in_index"/>

    <form method="post" action="/chord_set/insert">
      <div class="form">
	<h2>Add a new set:</h2>
	<div>
	  <input name="name" size="30"/>
	  <input type="submit" value="Add"/>
	  <input type="hidden" name="{$form_authenticity_token}" value="{$form_authenticity_token}"/>
	</div>
      </div>
    </form>
  </xsl:template>

</xsl:stylesheet>
