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
    <title>Chordbrowser</title>
  </xsl:template>

  <xsl:template match="*" mode="external_css">
    <link rel="stylesheet" href="/stylesheets/family.css" type="text/css"/>
  </xsl:template>

  <xsl:template match="families" mode="body">
    <body style="padding:1%;">
      <div class="content">
      </div>
      <div style="float:left;width:95%;margin-left:5%">

	<xsl:apply-templates select="." mode="xml_iframe"/>

      </div>


    </body>
  </xsl:template>

</xsl:stylesheet>
