<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
      <!DOCTYPE stylesheet [
<!ENTITY nbsp "&#160;">
<!ENTITY rsquo "&#8217;">
]>
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
	<xsl:apply-templates select="." mode="meta"/>
	<xsl:apply-templates select="." mode="title"/>
	<xsl:apply-templates select="." mode="style"/>
	<xsl:apply-templates select="." mode="script"/>
      </head>
      <xsl:apply-templates select="." mode="body"/>
    </html>
  </xsl:template>

  <xsl:template match="*" mode="meta">
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
  </xsl:template>

  <xsl:template match="*" mode="script">
    <script type="text/javascript" src="javascripts/prototype.js"></script>
    <script type="text/javascript" src="javascripts/effects.js"></script>
    <script type="text/javascript">
      function about() {
        if (Element.empty('about-content')) {
          new Ajax.Updater('about-content', 'rails/info/properties', {
            method:     'get',
            onFailure:  function() {Element.classNames('about-content').add('failure')},
            onComplete: function() {new Effect.BlindDown('about-content', {duration: 0.25})}
          });
        } else {
          new Effect[Element.visible('about-content') ? 
            'BlindUp' : 'BlindDown']('about-content', {duration: 0.25});
        }
      }
      
      window.onload = function() {
        $('search-text').value = '';
        $('search').onsubmit = function() {
          $('search-text').value = 'site:rubyonrails.org ' + $F('search-text');
        }
      }
    </script>
  </xsl:template>


  <xsl:template match="*" mode="style">
    <style type="text/css" media="screen">
      body {
        margin: 0;
        margin-bottom: 25px;
        padding: 0;
        background-color: #f0f0f0;
        font-family: "Lucida Grande", "Bitstream Vera Sans", "Verdana";
        font-size: 13px;
        color: #333;
      }
      
      h1 {
        font-size: 28px;
        color: #000;
      }
      
      a  {color: #03c}
      a:hover {
        background-color: #03c;
        color: white;
        text-decoration: none;
      }
      
      
      #page {
        background-color: #f0f0f0;
        width: 750px;
        margin: 0;
        margin-left: auto;
        margin-right: auto;
      }
      
      #content {
        float: left;
        background-color: white;
        border: 3px solid #aaa;
        border-top: none;
        padding: 25px;
        width: 500px;
      }
      
      #sidebar {
        float: right;
        width: 175px;
      }

      #footer {
        clear: both;
      }
      

      #header, #about, #getting-started {
        padding-left: 75px;
        padding-right: 30px;
      }


      #header {
        background-image: url("images/rails.png");
        background-repeat: no-repeat;
        background-position: top left;
        height: 64px;
      }
      #header h1, #header h2 {margin: 0}
      #header h2 {
        color: #888;
        font-weight: normal;
        font-size: 16px;
      }
      
      
      #about h3 {
        margin: 0;
        margin-bottom: 10px;
        font-size: 14px;
      }
      
      #about-content {
        background-color: #ffd;
        border: 1px solid #fc0;
        margin-left: -11px;
      }
      #about-content table {
        margin-top: 10px;
        margin-bottom: 10px;
        font-size: 11px;
        border-collapse: collapse;
      }
      #about-content td {
        padding: 10px;
        padding-top: 3px;
        padding-bottom: 3px;
      }
      #about-content td.name  {color: #555}
      #about-content td.value {color: #000}
      
      #about-content.failure {
        background-color: #fcc;
        border: 1px solid #f00;
      }
      #about-content.failure p {
        margin: 0;
        padding: 10px;
      }
      
      
      #getting-started {
        border-top: 1px solid #ccc;
        margin-top: 25px;
        padding-top: 15px;
      }
      #getting-started h1 {
        margin: 0;
        font-size: 20px;
      }
      #getting-started h2 {
        margin: 0;
        font-size: 14px;
        font-weight: normal;
        color: #333;
        margin-bottom: 25px;
      }
      #getting-started ol {
        margin-left: 0;
        padding-left: 0;
      }
      #getting-started li {
        font-size: 18px;
        color: #888;
        margin-bottom: 25px;
      }
      #getting-started li h2 {
        margin: 0;
        font-weight: normal;
        font-size: 18px;
        color: #333;
      }
      #getting-started li p {
        color: #555;
        font-size: 13px;
      }
      
      
      #search {
        margin: 0;
        padding-top: 10px;
        padding-bottom: 10px;
        font-size: 11px;
      }
      #search input {
        font-size: 11px;
        margin: 2px;
      }
      #search-text {width: 170px}
      
      
      #sidebar ul {
        margin-left: 0;
        padding-left: 0;
      }
      #sidebar ul h3 {
        margin-top: 25px;
        font-size: 16px;
        padding-bottom: 10px;
        border-bottom: 1px solid #ccc;
      }
      #sidebar li {
        list-style-type: none;
      }
      #sidebar ul.links li {
        margin-bottom: 5px;
      }
      
    </style>
  </xsl:template>

  <xsl:template match="*" mode="title">
    <title>Ruby on Rails: Welcome aboard</title>
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
            <h2>You&rsquo;re riding Ruby on Rails!</h2>
          </div>
	  
          <div id="about">
            <h3><a href="rails/info/properties" onclick="about(); return false">About your application&rsquo;s environment</a></h3>
            <div id="about-content" style="display: none"></div>
          </div>
          
          <div id="getting-started">
            <h1>Getting started</h1>
            <h2>Here&rsquo;s how to get rolling:</h2>
            
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
	
	<div id="footer">&nbsp;</div>
      </div>
    </body>
    
  </xsl:template>

  <xsl:template match="*" mode="xml_iframe">
    <div class="xml_iframe" style="float:right;width:50%">
      <iframe src="?output=xml"/>
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
