<?xml version="1.0"?>
<!DOCTYPE stylesheet [
<!ENTITY doubleleft "&#171;">
]>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="public/stylesheets/chordbrowser.xsl"/>
  <xsl:include href="public/stylesheets/chord.xsl"/>

  <xsl:param name="edit_chord"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page"/>
  </xsl:template>

  <xsl:template match="chord" mode="menu">
    <h2><a href="/">&doubleleft; Families</a></h2><h2><a href="/family/view/{@family_id}">&#171; Family: <xsl:value-of select="@family"/></a></h2>
    <h2>Editing Chord: <xsl:value-of select="@name"/></h2>
  </xsl:template>

  <xsl:template match="chords">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="chord">
    <div style="float:left">
      <xsl:apply-templates select="." mode="edit"/>
    </div>
  </xsl:template>

  <xsl:template match="chord" mode="edit">
    <form action="/chord/save/{@id}" method="post">
      <div class="chord">
	<input name="name" value="{@name}"/>
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
	<div class="save">
	  <input type="submit" value="Save"/>
	</div>
      </div>
    </form>
  </xsl:template>

  <!-- FIXME: refactor with public/stylesheets/chord.xsl.
       (match="edit/chord/fret/@*" mode="nut") -->
  <xsl:template match="chord/fret/@*" mode="nut">
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

  <xsl:template match="chord/fret/@*" mode="fret">
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

</xsl:stylesheet>
