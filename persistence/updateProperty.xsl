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
       The following template matches everything - just copies to output -->
  <xsl:import href="identity.xsl"/>
  <xsl:import href="settings.xsl"/>

  <xsl:param name="persistenceUnitName"/>
  <xsl:param name="propertyName"/>
  <xsl:param name="propertyValue"/>

  <!-- Define the property attributes to be used -->
  <xsl:attribute-set name="propertyAttributes">
    <xsl:attribute name="name">
      <xsl:value-of select="$propertyName"/>
    </xsl:attribute>
    <xsl:attribute name="value">
      <xsl:value-of select="$propertyValue"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Update the property with the given name in the given persistence unit by assigning the propertyAttributes above -->
  <xsl:template match="property">
    <xsl:choose>
      <xsl:when test="(@name = $propertyName) and (../../@name = $persistenceUnitName)">
        <xsl:element name="property" use-attribute-sets="propertyAttributes" namespace="http://java.sun.com/xml/ns/persistence"/>
      </xsl:when>
      <xsl:otherwise> <!-- It is another element and so should just be copied to the output -->
        <xsl:call-template name="identity"/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

</xsl:stylesheet>
