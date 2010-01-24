<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:param name="format"/>
  <xsl:param name="table"/>
  <xsl:param name="expression_id"/>

  <xsl:include href="/home/ekoontz/chordbrowser/public/stylesheets/page.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>


  <xsl:template match="*" mode="titlex">
    <title>Chordbrowser: Chord Family C#</title>
  </xsl:template>


  <xsl:template match="family" mode="headerx">
    <div>
      <h2>Chord Family: C#</h2>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="family" mode="bodyx">
    <body>
      <div style="float:left;width:100%">
	<h2>Chords in this family:</h2>
	
	<ul>
	  <li>C#</li>
	  <li>C#7</li>
	  <li>C#min</li>
	</ul>
	Choose another chord family...
      </div>

      <xsl:apply-templates select="." mode="xml_iframe"/>

    </body>
  </xsl:template>

</xsl:stylesheet>
