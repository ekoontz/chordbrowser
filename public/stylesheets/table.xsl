<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:param name="prefix"/>

  <xsl:template match="*[@count = 0]" mode="table">
    <div style="text-align:center;font-style:italic">No results.</div>
  </xsl:template>

  <xsl:template match="@*" mode="table_inputs">
    <th><xsl:value-of select="name()"/></th>
    <td><input type="hidden" name="{name()}" value="{.}"/></td>
  </xsl:template>

  <xsl:template match="*" mode="table">
    <xsl:param name="prefix"/>
    <xsl:param name="inputs">
      <xsl:apply-templates select="@*" mode="table_inputs"/>
    </xsl:param>

    <div class="table">

      <xsl:variable name="prefix_and_underscore"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if></xsl:variable>

      <form method="get" action="?">
	<xsl:copy-of select="$inputs"/>
	<input type="hidden" name="page" id="{$prefix_and_underscore}page"/>
	<xsl:if test="@count &gt; @limit">
	  <div class="pager">
	    <table>
	      <tbody>
		<tr>
		  <th class="left">
		    <button onclick="page_to_beginning()">
		      <xsl:if test="@offset = '0'">
			<xsl:attribute name="disabled">disabled</xsl:attribute>
		      </xsl:if>
		      &lt;&lt;
		  </button></th>
		  <th class="left">
		    <button onclick="page_back()">
		      <xsl:if test="@offset = '0'">
			<xsl:attribute name="disabled">disabled</xsl:attribute>
		      </xsl:if>
		      &lt;</button></th>
		  <xsl:variable name="upto">
		    <xsl:choose>
		      <xsl:when test="(@offset + @limit) &gt; @count">
			<xsl:value-of select="@count"/>
		      </xsl:when>
		      <xsl:otherwise>
			<xsl:value-of select="@offset + @limit"/>
		      </xsl:otherwise>
		    </xsl:choose>
		  </xsl:variable>
		  
		  <th style="width:40%;text-align:center;">
		    Showing <xsl:value-of select="@offset + 1"/>-<xsl:value-of select="$upto"/> of <xsl:value-of select="@count"/> rows.
		  </th>
		  <th class="right"><button onclick="page_forward()">
		      <xsl:if test="(@offset + 10) &gt; @count">
			<xsl:attribute name="disabled">disabled</xsl:attribute>
		      </xsl:if>
		      &gt;</button>
		  </th>
		  <th class="right">
		    <button onclick="page_to_end()">
		      <xsl:if test="(@offset + 10) &gt; @count">
			<xsl:attribute name="disabled">disabled</xsl:attribute>
		      </xsl:if>
		      &gt;&gt;</button>
		  </th>
		</tr>
	      </tbody>
	    </table>
	  </div>
	</xsl:if>
      </form>

      <table>
	<thead>
	  <xsl:apply-templates select="*[position() = 1]" mode="thead">
	  </xsl:apply-templates>
	</thead>
	<tbody>
	  <xsl:apply-templates select="*" mode="tbody"/>
	</tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="*" mode="thead">
    <tr>
      <th/>
      <xsl:apply-templates select="@*" mode="th"/>
    </tr>
  </xsl:template>

  <xsl:template match="@*" mode="th">
    <th><xsl:value-of select="name()"/></th>
  </xsl:template>

  <xsl:template match="*" mode="tbody">
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
      <xsl:apply-templates select="@*" mode="td"/>
    </tr>
  </xsl:template>

  <xsl:template match="@*" mode="td">
    <td><xsl:value-of select="."/></td>
  </xsl:template>

</xsl:stylesheet>
