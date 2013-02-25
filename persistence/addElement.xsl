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
  <xsl:import href="identity.xsl"/>
  <xsl:import href="settings.xsl"/>

  <xsl:param name="persistenceUnitName"/>
  <xsl:param name="elementName"/>
  <xsl:param name="elementValue"/>

  <!-- Find a persistence-unit -->
  <xsl:template match="persistence-unit">
    <!-- The output persistence-unit must be wrapped in a persistence-unit with the same attributes -->
    <xsl:variable name="currentName" select="@name" />
    <xsl:variable name="transactionType" select="@transaction-type" />
    <persistence-unit name="{$currentName}" transaction-type="{$transactionType}" xmlns="http://java.sun.com/xml/ns/persistence">
    <!-- For each node in that persistence-unit (which can be either <properties> or a general element)... -->
    <xsl:for-each select="node()">
      <!-- First check what type of node it is. Note that we copy all nodes that *do not* match the general element to be added, and omit those that *do* -->
      <xsl:if test="not((name() = $elementName) and (text() = $elementValue) and (../@name = $persistenceUnitName))">
        <xsl:call-template name="identity"/>
      </xsl:if>
    </xsl:for-each>
    <!-- Note the use of xsl:message to inspect the current value of @name - should be that of the enclosing persistence unit -->
    <!--xsl:message>
      <xsl:copy-of select="@name"/>
    </xsl:message-->
    <!-- If we are in the right persistence-unit, add the specified general element -->
    <xsl:if test="(@name = $persistenceUnitName)">
      <xsl:element name="{$elementName}"><xsl:value-of select="$elementValue"/></xsl:element>
    </xsl:if>
    </persistence-unit>
  </xsl:template>

</xsl:stylesheet>
