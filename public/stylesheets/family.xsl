<?xml version="1.0"?>
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
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="family">
    <div class="family">
      <h2><a href="/family/view/{@name}"><xsl:value-of select="@name"/></a></h2>
      <div class="chords">
	<xsl:apply-templates select="chord"/>
      </div>

      <div style="float:left;width:100%">
	<xsl:choose>
	  <xsl:when test="$action = 'new'">
	    <form method="post">
	      <div style="float:left;border:2px dashed #f0f0f0;padding:0.25em;margin:0.25em">
		<h3>Add a new chord to the <b><xsl:value-of select="@name"/></b> family:</h3>
		<xsl:apply-templates select="../edit/chord"/>
		<div style="float:right;text-align:right;width:100%">
		  <input type="submit" value="Add Chord"/>
		</div>
	      </div>
	    </form>
	  </xsl:when>
	  <xsl:otherwise>
	    <a href="/family/newchord/{@name}">add a new chord to this family</a>
	  </xsl:otherwise>
	</xsl:choose>
      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>
