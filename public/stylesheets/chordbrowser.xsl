<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:include href="page.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="*" mode="title">
    <title>Chordbrowser</title>
  </xsl:template>

  <xsl:template match="*" mode="menu">
    <div class="menu">
      <h2><a href="/family">Families</a></h2>
      <h2><a href="/chord">Chords</a></h2>
      <h2><a href="/song">Songs</a></h2>
    </div>
  </xsl:template>

  <xsl:template match="*" mode="external_css">
    <link rel="stylesheet" href="/stylesheets/chordbrowser.css" type="text/css"/>
    <link rel="stylesheet" href="/stylesheets/family.css" type="text/css"/>
    <link rel="stylesheet" href="/stylesheets/chord.css" type="text/css"/>
  </xsl:template>

  <xsl:template match="*" mode="body">
    <body style="padding:1%">
      <h1>Chordbrowser</h1>

      <xsl:apply-templates select="." mode="menu"/>

      <div class="content">
	<xsl:apply-templates select="."/>
      </div>

      <div style="float:left;width:95%;margin-left:5%">
	<xsl:apply-templates select="." mode="xml_iframe"/>
      </div>

      <div class="colophon">
	<div>
	  <a href="mailto:ekoontz@hiro-tan.org">ekoontz@hiro-tan.org</a>
	</div>
	<div>
	  <a href="http://wiki.github.com/ekoontz/chordbrowser/">Source Code</a>
	</div>
      </div>

    </body>
  </xsl:template>

</xsl:stylesheet>
