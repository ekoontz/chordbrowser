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

  <xsl:template match="*" mode="external_css">
    <link rel="stylesheet" href="/stylesheets/chord.css" type="text/css"/>
  </xsl:template>

  <xsl:template match="chords" mode="body">
    <body style="padding:1%">
      <h1>Chordbrowser</h1>

      <xsl:apply-templates select="chord"/>

      <div style="float:left;width:95%;margin-left:5%">
	<xsl:apply-templates select="." mode="xml_iframe"/>
      </div>

    </body>
  </xsl:template>

  <xsl:template match="chord">
    <div class="chord">
      <h2><xsl:value-of select="@name"/></h2>
      <table class="chord">
	<thead>
	  <tr>
	    <th/>
	    <th class="string">E</th>
	    <th class="string">A</th>
	    <th class="string">D</th>
	    <th class="string">G</th>
	    <th class="string">B</th>
	    <th class="string">E</th>
	  </tr>
	  <tr>
	    <th/>
	    <th class="nut">
	      <xsl:apply-templates select="@e_low" mode="nut"/>
	    </th>
	    <th class="nut">
	      <xsl:apply-templates select="@a" mode="nut"/>
	    </th>
	    <th class="nut">
	      <xsl:apply-templates select="@d" mode="nut"/>
	    </th>
	    <th class="nut">
	      <xsl:apply-templates select="@g" mode="nut"/>
	    </th>
	    <th class="nut">
	      <xsl:apply-templates select="@b" mode="nut"/>
	    </th>
	    <th class="nut">
	      <xsl:apply-templates select="@e" mode="nut"/>
	    </th>
	  </tr>
	</thead>
	<tbody class="chord">
	  
	  <xsl:apply-templates select="." mode="fret">
	    <xsl:with-param name="fret">1</xsl:with-param>
	  </xsl:apply-templates>
	  
	  <xsl:apply-templates select="." mode="fret">
	    <xsl:with-param name="fret">2</xsl:with-param>
	  </xsl:apply-templates>
	  
	  <xsl:apply-templates select="." mode="fret">
	    <xsl:with-param name="fret">3</xsl:with-param>
	  </xsl:apply-templates>
	  
	  <xsl:apply-templates select="." mode="fret">
	    <xsl:with-param name="fret">4</xsl:with-param>
	  </xsl:apply-templates>
	  
	</tbody>
	
      </table>
    </div>
  </xsl:template>

  <xsl:template match="@*" mode="nut">
    <xsl:choose>
      <xsl:when test=".='x'">x</xsl:when>
      <xsl:when test=".='open'">o</xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="chord" mode="fret">
    <xsl:param name="fret"/>
    <tr>
      <th><xsl:value-of select="$fret"/></th>
      <td>
	<xsl:apply-templates select="@e_low" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
      <td>
	<xsl:apply-templates select="@a" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
      <td>
	<xsl:apply-templates select="@d" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
      <td>
	<xsl:apply-templates select="@g" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
      <td>
	<xsl:apply-templates select="@b" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
      <td>
	<xsl:apply-templates select="@e" mode="fret">
	  <xsl:with-param name="fret"><xsl:value-of select="$fret"/></xsl:with-param>
	</xsl:apply-templates>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="@*" mode="fret">
    <xsl:param name="fret"/>
    <xsl:if test=". = $fret"><xsl:value-of select="."/></xsl:if>
  </xsl:template>


</xsl:stylesheet>
