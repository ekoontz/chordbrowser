<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <!-- first fret's position is a dropdown so you can specify an
       'up-the-neck' chord. -->
  <xsl:template match="chord/fret[@number='1']" mode="edit_fret_number">
    <xsl:variable name="actual_first_fret" 
		  select="@number + ancestor::chord/@fret_offset - 1"/>
    <select name="fret_offset"
	    onchange="renumber_frets(this)">
      <xsl:call-template name="options">
	<xsl:with-param name="from">1</xsl:with-param>
	<xsl:with-param name="to">9</xsl:with-param>
	<xsl:with-param name="selected" select="$actual_first_fret"/>
      </xsl:call-template>
    </select>
  </xsl:template>

  <xsl:template name="options">
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:param name="selected"/>
    <xsl:if test="$from &lt;= $to">
      <xsl:call-template name="option">
	<xsl:with-param name="value" select="$from"/>
	<xsl:with-param name="selected" select="$selected"/>
      </xsl:call-template>
      <xsl:call-template name="options">
	<xsl:with-param name="from" select="$from + 1"/>
	<xsl:with-param name="to" select="$to"/>
	<xsl:with-param name="selected" select="$selected"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="option">
    <xsl:param name="value"/>
    <xsl:param name="selected"/>
    <option>
      <xsl:if test="$selected = $value">
	<xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="$value"/>
    </option>
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

  <xsl:template match="chord/fret[@number='1']/@*" mode="edit_fret">
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

  <xsl:template match="chord/fret[not(@number='1')]/@*" mode="edit_fret">
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
