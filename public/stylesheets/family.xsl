<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:include href="/home/ekoontz/chordbrowser/public/stylesheets/page.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="*" mode="title">
    <title>Chordbrowser: Chord Family: C#</title>
  </xsl:template>

  <xsl:template match="family" mode="body">
    <body style="padding:1%">
      <h1>Chordbrowser: Chord Family: C#</h1>
      <h2><a href="/family">Families</a></h2>
      <h2><a href="/chord">Chords</a></h2>
      <h2><a href="/song">Songs</a></h2>
      <div style="float:left;width:95%;margin-left:5%">
	<h2>Chords in this family:</h2>
	
	<ul>
	  <li><a href="/chord/csharp">C#</a></li>
	  <li><a href="/chord/charp7">C#7</a></li>
	  <li><a href="/chord/csharpmin">C#min</a></li>
	</ul>

	<xsl:apply-templates select="." mode="xml_iframe"/>

      </div>


    </body>
  </xsl:template>

</xsl:stylesheet>
