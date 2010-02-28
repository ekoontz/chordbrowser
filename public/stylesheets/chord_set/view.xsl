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

  <xsl:template match="/chord_sets" mode="menu">
    <h2><a href="/family/">&doubleleft; Families</a></h2>
    <h2><a href="/chord_set/">&doubleleft; Sets</a></h2>
    <h2>Set: <xsl:value-of select="chord_set[1]/@name"/></h2>
  </xsl:template>

  <xsl:template match="chord_sets">
    <xsl:apply-templates select="chord_set"/>
  </xsl:template>

  <xsl:template match="chord_set">
    <div class="chord_set">
      <div class="chords">
	<xsl:apply-templates select="ancestor::chord_sets/chords/chord">
	  <xsl:with-param name="edit">false</xsl:with-param>
	</xsl:apply-templates>
      </div>
      <a href="">add more chords to this set</a>
    </div>
  </xsl:template>

  <xsl:template match="chord" mode="title">
    <div style="width:100%;float:left;padding:0">
      <h2 style="padding:0;margin:0">
	<a href="/family/view/{@family_id}">
	  <xsl:value-of select="@name"/>
	</a>
	</h2>
    </div>
  </xsl:template>

  <!-- don't show chord-editing control within set. -->
  <xsl:template match="chord" mode="edit"/>

  <xsl:template match="chord" mode="delete">
    <div style="width:20%;float:right">
      <xsl:if test="$current_user">
	<form method="post" action="/chord_set/remove_chord/{@id}">
	  <input name="chord_set_id" 
		 type="hidden"
		 value="{ancestor::chord_sets/chord_set/@id}"/>
	  <div style="float:right">
	    <input onclick="if (confirm('Remove {@name} from this set?')) submit(); else return false;" type="submit" value="Remove"/>
	  </div>
	</form>
      </xsl:if>
    </div>
  </xsl:template>

</xsl:stylesheet>
