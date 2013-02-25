<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://maven.apache.org/POM/4.0.0">
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

  <xsl:param name="id"/>
  <xsl:param name="url"/>
  <xsl:param name="name"/>
  <xsl:param name="extraXML"/>

  <!-- See http://www.daniweb.com/software-development/xml-xslt-and-xpath/threads/167809/adding-new-element-using-xslt -->
  <xsl:template match="repositories">
    <repositories xmlns="http://maven.apache.org/POM/4.0.0">
      <xsl:for-each select="node()">
        <xsl:call-template name="identity"/>
      </xsl:for-each>
      <repository xmlns="http://maven.apache.org/POM/4.0.0">
        <xsl:element name="id"><xsl:value-of select="$id"/></xsl:element>
        <xsl:element name="url"><xsl:value-of select="$url"/></xsl:element>
        <xsl:element name="name"><xsl:value-of select="$name"/></xsl:element>
        <xsl:if test="$extraXML != ''">
          <xsl:copy-of select="document($extraXML)/*"/>
        </xsl:if>
      </repository>
    </repositories>
  </xsl:template>

</xsl:stylesheet>
