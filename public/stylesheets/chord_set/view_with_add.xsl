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
  <xsl:include href="public/stylesheets/chord_set/view_lib.xsl"/>

  <xsl:template match="/chord_sets" mode="menu">
    <h2><a href="/family/">&doubleleft; Families</a></h2>
    <h2><a href="/chord_set/">&doubleleft; Sets</a></h2>
    <h2><a href="/chord_set/{chord_set[1]/@id}">&doubleleft; Set: <xsl:value-of select="chord_set[1]/@name"/></a></h2>
    <h2>Add a chord to this set</h2>
  </xsl:template>


  <xsl:template match="chord_set">
    <div class="chord_set">
      <div class="chords">
	<xsl:apply-templates select="ancestor::chord_sets/add/chords"/>
      </div>
    </div>

    <h3>Current members</h3>
    <div class="chord_set">
      <div class="chords">
	<xsl:apply-templates select="ancestor::chord_sets/chords"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="add/chords/chord" mode="delete">
    <!-- this overrides the 'delete' mode, but actually it's for adding a chord to a new set.-->
    <div style="width:20%;float:right">
      <xsl:if test="$current_user">
	<form method="post" action="/chord_set/add_chord/{@id}">
	  <input name="chord_set_id" type="hidden"
		 value="{ancestor::chord_sets/chord_set/@id}"/>
	  <div style="float:right">
	    <input type="submit" value="Add"/>
	  </div>
	</form>
      </xsl:if>
    </div>
  </xsl:template>

</xsl:stylesheet>
