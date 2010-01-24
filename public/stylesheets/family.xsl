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
      <div style="float:left;width:95%;margin-left:5%">
	<h2>Chords in this family:</h2>
	
	<ul>
	  <li>C#</li>
	  <li>C#7</li>
	  <li>C#min</li>
	</ul>
	Choose another chord family...


	<xsl:apply-templates select="." mode="xml_iframe"/>


      </div>


    </body>
  </xsl:template>

  <xsl:template match="*" mode="xml_iframe">
    <div class="xml_iframe" style="float:right;width:50%">
      <iframe height="300" width="400" id="as_xml_iframe" src="?output=xml"/>
    </div>
  </xsl:template>


</xsl:stylesheet>
