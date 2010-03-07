<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <!-- might move one or more of these to page.xsl. -->
  <xsl:param name="flash_notice"/>
  <xsl:param name="current_user"/>
  <xsl:param name="xsl"/>
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

  <xsl:template match="*" mode="script">
    <script type="text/javascript" src="/javascripts/chordbrowser.js"></script>
  </xsl:template>

  <xsl:template match="*" mode="body">
    <body>
      <div class="header">
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
      </div>

      <xsl:if test="$flash_notice">
	<div id="flash_notice">
	  <xsl:value-of select="$flash_notice"/>
	</div>
      </xsl:if>

      <div class="menu">
	<xsl:apply-templates select="." mode="menu"/>
      </div>

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
	<xsl:with-param name="style">top:17em</xsl:with-param>
	<xsl:with-param name="title"><a target="_new" href="/{$xsl}"><xsl:value-of select="$xsl"/></a></xsl:with-param>
      </xsl:apply-templates>

    </body>
  </xsl:template>

</xsl:stylesheet>
