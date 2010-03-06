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
  <xsl:include href="public/stylesheets/chord_set/lib.xsl"/>
  <xsl:include href="public/stylesheets/chord_set/view_lib.xsl"/>

  <xsl:template match="chord_set">
    <div class="chord_set">
      <div class="chords">
	<xsl:apply-templates select="ancestor::chord_sets/chords"/>
      </div>
      <xsl:if test="$current_user">
	<div style="float:left;width:40%;margin:1em;">
	  <a href="/chord_set/view_with_add/{@id}">Add chords to this set</a>
	</div>
      </xsl:if>
    </div>
  </xsl:template>


</xsl:stylesheet>
