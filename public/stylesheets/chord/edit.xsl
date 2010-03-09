<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <!-- first fret's position is a dropdown so you can specify an
       'up-the-neck' chord. -->
  <xsl:template match="chord/fret[@number='1']" mode="edit_fret_number">
    <xsl:param name="fret" select="@number"/>
    <select name="fret_offset"
	    onchange="renumber_frets(this)">
      <option>1</option>
      <option>2</option>
      <option>3</option>
      <option>4</option>
      <option>5</option>
      <option>6</option>
      <option>7</option>
      <option>8</option>
    </select>
  </xsl:template>

  <xsl:template match="chord/fret[@number='nut']/@*" mode="edit_nut">
    <select name="fret[nut][{name()}]]">
      <option/>
      <option>
	<xsl:if test=". = 'x'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>x</option>
      <option value="open">
	<xsl:if test=". = 'open'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>o</option>
    </select>
  </xsl:template>

  <xsl:template match="chord/fret/@*" mode="edit_fret">
    <select name="fret[{../@number}][{name()}]">
      <option/>
      <option value="1">
	<xsl:if test=". = '1'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>
	1
      </option>
      <option value="2">
	<xsl:if test=". = '2'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>
	2
      </option>
      <option value="3">
	<xsl:if test=". = '3'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>
	3
      </option>
      <option value="4">
	<xsl:if test=". = '4'">
	  <xsl:attribute name="selected">selected</xsl:attribute>
	</xsl:if>
	4
      </option>
    </select>
  </xsl:template>

  <xsl:template match="edit"/>

</xsl:stylesheet>
