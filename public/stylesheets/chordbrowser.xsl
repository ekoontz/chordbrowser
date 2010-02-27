<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <!-- might move one or more of these to page.xsl. -->
  <xsl:param name="flash_notice"/>
  <xsl:param name="current_user"/>
  <!-- /might move one or more of these to page.xsl. -->

  <xsl:include href="page.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="*" mode="title">
    <title>Chordbrowser</title>
  </xsl:template>

  <xsl:template match="*" mode="external_css">
    <link rel="stylesheet" href="/stylesheets/page.css" type="text/css"/>
    <link rel="stylesheet" href="/stylesheets/chordbrowser.css" type="text/css"/>
    <link rel="stylesheet" href="/stylesheets/family.css" type="text/css"/>
    <link rel="stylesheet" href="/stylesheets/chord.css" type="text/css"/>
  </xsl:template>

  <xsl:template match="*" mode="body">
    <body style="padding:1%">
      <h1>Chordbrowser</h1>
      
      <div id="user_nav">
	<xsl:choose>
	  <xsl:when test="$current_user">
	    <a href="/users/current/edit">Edit Profile</a>
	    |
	    <a href="/logout">Logout</a>
	  </xsl:when>
	  <xsl:otherwise>
	    <a href="/users/new">Register</a>
	    |
	    <a href="/login">Login</a>
	  </xsl:otherwise>
	</xsl:choose>
      </div>

      <xsl:if test="$flash_notice">
	<div id="flash_notice">
	  <xsl:value-of select="$flash_notice"/>
	</div>
      </xsl:if>

      <xsl:apply-templates select="." mode="menu"/>

      <div class="content">
	<xsl:apply-templates select="."/>
      </div>

      <div class="colophon">
	<div style="whitespace:nowrap">
	  by Eugene Koontz &lt;<a href="mailto:ekoontz@hiro-tan.org">ekoontz@hiro-tan.org</a>&gt;
	</div>
	<div>
	  <a href="http://github.com/ekoontz/chordbrowser/">Source Code</a>
	</div>
      </div>


      <xsl:apply-templates select="." mode="xml_div"/>

      <xsl:apply-templates select="." mode="xml_div">
	<xsl:with-param name="src">?output=xsl</xsl:with-param>
	<xsl:with-param name="style">top:15em</xsl:with-param>
      </xsl:apply-templates>

    </body>
  </xsl:template>

</xsl:stylesheet>
