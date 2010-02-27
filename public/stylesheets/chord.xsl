<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="chords">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="chord">
    <div class="chord">
      <xsl:if test="@name">
	<div style="width:100%;float:left">
	  <div style="width:100%;float:left;padding:0">
	    <h2 style="padding:0;margin:0"><xsl:value-of select="@name"/></h2>
	  </div>
	  <xsl:if test="$current_user">
	    <div style="width:20%;float:left">
	      <a href="/chord/edit/{@id}">edit</a>
	    </div>
	  </xsl:if>
	  <div style="width:20%;float:right">
	    <xsl:if test="$current_user">
	      <form method="post" action="/chord/delete/{@id}">
		<div style="float:right">
		  <input onclick="if (confirm('Delete this chord ({@name})?')) submit(); else return false;" type="submit" value="Delete"/>
		</div>
	      </form>
	    </xsl:if>
	  </div>
	</div>
      </xsl:if>
      <div style="float:left">
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
	    <xsl:apply-templates select="fret[@number = 'nut']"/>
	  </thead>
	  <tbody class="chord">
	    <xsl:apply-templates select="fret[@number = '1']"/>
	    <xsl:apply-templates select="fret[@number &gt; '1']"/>
	  </tbody>
	</table>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="fret[@number='nut']">
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
  </xsl:template>    

  <xsl:template match="@*" mode="nut">
    <xsl:choose>
      <xsl:when test=".='x'">x</xsl:when>
      <xsl:when test=".='open'">o</xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="fret">
    <xsl:param name="fret" select="@number"/>
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
    <xsl:if test="."><xsl:value-of select="."/></xsl:if>
  </xsl:template>

</xsl:stylesheet>
