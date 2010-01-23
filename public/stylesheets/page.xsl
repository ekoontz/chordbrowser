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

  <xsl:include href="table.xsl"/>

  <xsl:template match="/" mode="page">
    <xsl:param name="title" select="'untitled'"/>
    <xsl:param name="onload"/>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
      <head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<xsl:apply-templates select="." mode="title"/>
	<xsl:apply-templates select="." mode="css"/>

	<xsl:apply-templates select="." mode="page_specific_meta"/>

        <script type="text/javascript" src="/javascripts/prototype.js">
	</script>
        <script type="text/javascript" src="/javascripts/application.js">
	</script>
        <script type="text/javascript" src="/javascripts/jquery.js">
	</script>
      </head>
      <xsl:apply-templates select="." mode="body"/>
    </html>
  </xsl:template>

  <xsl:template match="*" mode="css">
	<link href="/stylesheets/page.css"
	      media="screen" rel="stylesheet" type="text/css" />
  </xsl:template>

  <xsl:template match="*" mode="title">
    <title>page.xsl : default title</title>
  </xsl:template>

  <xsl:template match="*" mode="tabs">
    page.xsl default tabs
  </xsl:template>

  <xsl:template match="*" mode="header">
    page.xsl default header
  </xsl:template>

  <xsl:template match="*" mode="header_main">
    <xsl:apply-templates 
       select="ancestor-or-self::view/metadata/tables/table" 
       mode="link"/>
  </xsl:template>
  
  <xsl:template match="table" mode="link">
    <xsl:variable name="link"><xsl:choose>
	<xsl:when test="$table">table=<xsl:value-of select="@name"/>&amp;join1=<xsl:value-of select="@name"/></xsl:when>
	<xsl:otherwise>table=<xsl:value-of select="@name"/>&amp;expression_id=<xsl:value-of select="$expression_id"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a href="?{$link}"><xsl:value-of select="@name"/></a>
  </xsl:template>

  <xsl:template match="*" mode="body">
    <!-- copied from public/index.html (Default Rails index.html)-->
    <body>
      <div id="page">
	<div id="sidebar">
          <ul id="sidebar-items">
            <li>
              <form id="search" action="http://www.google.com/search" method="get">
		<input type="hidden" name="hl" value="en" />
		<input type="text" id="search-text" name="q" value="site:rubyonrails.org " />
		<input type="submit" value="Search" /> the Rails site
              </form>
            </li>
            
            <li>
              <h3>Join the community</h3>
              <ul class="links">
		<li><a href="http://www.rubyonrails.org/">Ruby on Rails</a></li>
		<li><a href="http://weblog.rubyonrails.org/">Official weblog</a></li>
		<li><a href="http://wiki.rubyonrails.org/">Wiki</a></li>
              </ul>
            </li>
            
            <li>
              <h3>Browse the documentation</h3>
              <ul class="links">
		<li><a href="http://api.rubyonrails.org/">Rails API</a></li>
		<li><a href="http://stdlib.rubyonrails.org/">Ruby standard library</a></li>
		<li><a href="http://corelib.rubyonrails.org/">Ruby core</a></li>
		<li><a href="http://guides.rubyonrails.org/">Rails Guides</a></li>
              </ul>
            </li>
          </ul>
	</div>
	
	<div id="content">
          <div id="header">
            <h1>Welcome aboard</h1>
            <h2>You're riding Ruby on Rails!</h2>
          </div>
	  
          <div id="about">
            <h3><a href="rails/info/properties" onclick="about(); return false">About your application's environment</a></h3>
            <div id="about-content" style="display: none"></div>
          </div>
          
          <div id="getting-started">
            <h1>Getting started</h1>
            <h2>Here's how to get rolling:</h2>
            
            <ol>          
              <li>
		<h2>Use <tt>script/generate</tt> to create your models and controllers</h2>
		<p>To see all available options, run it without parameters.</p>
              </li>
              
              <li>
		<h2>Set up a default route and remove or rename this file</h2>
		<p>Routes are set up in config/routes.rb.</p>
              </li>
	      
              <li>
		<h2>Create your database</h2>
		<p>Run <tt>rake db:migrate</tt> to create your database. If you're not using SQLite (the default), edit <tt>config/database.yml</tt> with your username and password.</p>
              </li>
            </ol>
          </div>
	</div>
	
	<div id="footer"><xsl:text> </xsl:text></div>
      </div>
    </body>
    
  </xsl:template>

  <xsl:template match="*" mode="xml_iframe">
    <div class="xml_iframe">
      <iframe id="as_xml_iframe" height="500" width="100%" src="?output=xml"/>
    </div>
  </xsl:template>

  <xsl:template match="*" mode="dropdown">
    <xsl:param name="top"/>
    <xsl:param name="selected"/>
    <xsl:param name="filterby"/>
    <xsl:param name="form_input_name"/>
    <xsl:param name="table_alias"/>
    <select name="{$form_input_name}">
      <xsl:copy-of select="$top"/>
      <xsl:apply-templates mode="option">
	<xsl:with-param name="filterby" select="$filterby"/>
	<xsl:with-param name="selected" select="$selected"/>
	<xsl:with-param name="table_alias" select="$table_alias"/>
      </xsl:apply-templates>
    </select>
  </xsl:template>

  <xsl:template match="*" mode="option">
    <xsl:param name="selected"/>
    <option>
      <xsl:if test="$selected = @name">
	<xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="@name"/>
    </option>
  </xsl:template>

  <xsl:template match="expression" mode="thead">
    <tr>
      <th/>
      <xsl:apply-templates select="@id" mode="th"/>
      <xsl:apply-templates select="@arity" mode="th"/>
      <xsl:apply-templates select="@string" mode="th"/>
      <xsl:apply-templates select="@form_code" mode="th"/>
      <xsl:apply-templates select="@comment" mode="th"/>
    </tr>
  </xsl:template>

  <xsl:template match="expression" mode="tbody">
    <xsl:variable name="offset">
      <xsl:choose>
	<xsl:when test="ancestor-or-self::*[@offset]/@offset">
	  <xsl:value-of select="ancestor-or-self::*[@offset]/@offset"/>
	</xsl:when>
	<xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr class="row row_{position() mod 2}">
      <th>
	<xsl:value-of select="position() + $offset"/></th>
      <xsl:apply-templates select="@id" mode="td"/>
      <xsl:apply-templates select="@arity" mode="td"/>
      <xsl:apply-templates select="@string" mode="td"/>
      <xsl:apply-templates select="@form_code" mode="td"/>
      <xsl:apply-templates select="@comment" mode="td"/>
    </tr>
  </xsl:template>


  <xsl:template match="expression/@id" mode="td">
    <td>
      <a href="?expression_id={.}"><xsl:value-of select="."/></a>
    </td>
  </xsl:template>

</xsl:stylesheet>
