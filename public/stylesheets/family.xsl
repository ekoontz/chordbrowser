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

  <xsl:param name="action"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="families">
    <xsl:apply-templates select="family"/>
  </xsl:template>

  <xsl:template match="families" mode="menu">
    <xsl:apply-templates mode="menu"/>
  </xsl:template>

  <xsl:template match="/family" mode="menu">
    <h2><a href="/">&doubleleft; Families</a></h2>
    <h2>Family: <xsl:value-of select="@name"/></h2>
  </xsl:template>

  <xsl:template match="*" mode="menu">
  </xsl:template>

  <xsl:template match="family">
    <div class="family">
      <h2><a href="/family/view/{@id}">Family <xsl:value-of select="@name"/></a></h2>
      <div class="chords">
	<xsl:apply-templates select="chord"/>
      </div>

      <div style="float:left;width:100%">
	<xsl:choose>
	  <xsl:when test="$action = 'new'">
	    <form method="post" action="/family/view/{@name}">
	      <div style="float:left;border:2px solid #f0f0f0;padding:1.5em;margin:0.25em">
		<!-- FIXME: incorporate fret_action=insert into 
		     action=/family/view/{@name} -->
		<input type="hidden" name="fret_action" value="insert"/>
		<input type="hidden" name="{$request_forgery_protection_token}" value="{$form_authenticity_token}"/>
		<input type="hidden" name="family" value="{@name}"/>
		<h3 style="padding:0;margin:0">Add a new chord to the '<b><xsl:value-of select="@name"/></b>' family:</h3>
		<div>
		  <label for="chord_name">Chord name:</label>
		  <input id="chord_name" name="name" size="4"/>
		</div>

		<xsl:apply-templates select="ancestor::families/chord_attributes" 
				     mode="checkboxes"/>
		
		<div style="float:left;">
		  <xsl:apply-templates select="../edit/chord"/>
		</div>
		<div style="float:right;text-align:right;width:100%">
		  <input type="submit" value="Add Chord"/>
		</div>
	      </div>
	    </form>
	  </xsl:when>
	  <xsl:otherwise>
	    <a href="/family/newchord/{@id}">add a new chord to this family</a>
	  </xsl:otherwise>
	</xsl:choose>
      </div>
    </div>

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
