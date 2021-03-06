<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:param name="mode">no-mode</xsl:param>
  <xsl:include href="public/stylesheets/chordbrowser.xsl"/>
  <xsl:include href="public/stylesheets/chord.xsl"/>
  <xsl:include href="public/stylesheets/family/view_no_includes.xsl"/>
  <xsl:include href="public/stylesheets/chord/edit.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
 </xsl:template>

  <xsl:template match="families" mode="menu">
    <h2><a href="/">&doubleleft; Families</a></h2>
    <xsl:apply-templates mode="menu"/>
  </xsl:template>

  <xsl:template match="family" mode="menu">
    <h2><a href="/family/view/{@id}">&doubleleft; Family <xsl:value-of select="@name"/></a></h2>
    <h2>Add a new chord</h2>
  </xsl:template>

  <xsl:template match="families">
    <xsl:apply-templates/>
    <xsl:apply-templates select="family" mode="newchord"/>
  </xsl:template>

  <xsl:template match="family" mode="newchord">
    <form method="post" action="/family/view/{@id}">
      <div class="form">
	<input type="hidden" name="fret_action" value="insert"/>
	<input type="hidden" name="{$request_forgery_protection_token}" value="{$form_authenticity_token}"/>
	<input type="hidden" name="family" value="{@name}"/>
	<h3 style="padding:0;margin:0">Add a new chord to the '<b><xsl:value-of select="@name"/></b>' family:</h3>
	<div>
	  <label for="chord_name">Chord name:</label>
	  <input id="chord_name" name="name" size="4"/>
	</div>
	
	<div style="float:left;">
	  <xsl:apply-templates select="../edit/chord"/>
	</div>
	<div style="float:right;text-align:right;width:50%;margin-right:25%">
	  <input type="submit" value="Add Chord"/>
	</div>
      </div>
    </form>
  </xsl:template>

  <xsl:template match="edit/chord/fret[@number='1']" mode="fret_number">
    <xsl:apply-templates select="." mode="edit_fret_number"/>
  </xsl:template>

  <xsl:template match="edit/chord/fret[@number='nut']/@*" mode="nut">
    <xsl:apply-templates select="." mode="edit_nut"/>
  </xsl:template>

  <xsl:template match="edit/chord/fret/@*" mode="fret">
    <xsl:apply-templates select="." mode="edit_fret"/>
  </xsl:template>

</xsl:stylesheet>
