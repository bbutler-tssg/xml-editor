<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://java.sun.com/xml/ns/persistence">
<!--
Copyright (c) 2013, Bernard Butler (Waterford Institute of Technology, Ireland), Project: FAME (08/SRC/I1403)
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 -  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 -  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 -  Neither the name of WATERFORD INSTITUTE OF TECHNOLOGY nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->
  <!-- Note that the default namespace has been specified above: see http://dh.obdurodon.org/xslt_basics.html
       The identity template matches everything - just copies to output -->
  <xsl:import href="identity.xsl"/>
  <xsl:import href="settings.xsl"/>

  <xsl:param name="persistenceUnitName"/>
  <xsl:param name="transactionType"/>

  <!-- Add the property with the given name in the given persistence unit by assigning the propertyAttributes above -->
  <xsl:template match="persistence-unit">
    <!-- Check that it does not match the persistence-unit name being added, before allowing it to be copied to the output -->
    <xsl:choose>
      <xsl:when test="not(@name = $persistenceUnitName)">
        <xsl:call-template name="identity"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <!-- Now add the attributes (that are not included in the xsl:copy above) -->
          <xsl:attribute name="name"><xsl:value-of select="$persistenceUnitName"/></xsl:attribute>
          <xsl:attribute name="transaction-type"><xsl:value-of select="$transactionType"/></xsl:attribute>
          <!-- The following creates a properties element, but repeated applications causes multiple nested properties elements -->
          <!--properties xmlns="http://java.sun.com/xml/ns/persistence"><xsl:apply-templates select="properties"/></properties-->
          <!-- The following also creates a properties element, but repeated application does not cause repeated properties elements -->
          <xsl:element name="properties" namespace="http://java.sun.com/xml/ns/persistence"></xsl:element>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
