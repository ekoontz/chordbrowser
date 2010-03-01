<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:template match="chord_sets" mode="view_in_index">
    <div class="table">
      <table>
	<thead>
	  <tr>
	    <th/>
	    <th>Name</th>
	    <th>Actions</th>
	  </tr>
	</thead>
	<tbody>
	  <xsl:apply-templates select="chord_set" mode="view_in_index"/>
	</tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="chord_set" mode="view_in_index">
    <tr>
      <xsl:choose>
	<xsl:when test="position() mod 2 = 0">
	  <xsl:attribute name="class">even</xsl:attribute>
	</xsl:when>
	<xsl:otherwise/>
      </xsl:choose>
      <th class="numbering"><xsl:value-of select="position()"/></th>
      <td>
	<a href="/chord_set/view/{@id}"><xsl:value-of select="@name"/></a>
      </td>
      <td>
	<form>
	  <div>
	    <form method="post" action="/chord_set/delete/{@id}">
	      <div style="float:right">
		<input onclick="if (confirm('Delete this set ({@name})?')) submit(); else return false;" type="submit" value="Delete"/>
	      </div>
	    </form>
	  </div>
	</form>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
