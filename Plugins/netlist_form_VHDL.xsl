<?xml version="1.0" encoding="ISO-8859-1"?>
<!--XSL style sheet to EESCHEMA Generic Netlist Format to CADSTAR netlist format
    Copyright (C) 2014, Esteve Farrés Beremguer

    GPL v2.

    How to use:
         see eeschema.pdf, chapter 14

    c:\'Program Files (x86)'\KiCad\bin\xsltproc.exe -o out.vhd netlist_form_VHDL.xsl in.xml
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nl  "&#xd;&#xa;"> <!--new line CR, LF -->
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

<!-- Netlist header -->
<xsl:template match="/export">
    <xsl:apply-templates name="Date" select="design/date"/>  <!-- Generate line .TIM <time> -->
    <xsl:apply-templates name="Tool" select="design/tool"/>  <!-- Generate line .APP <eeschema version> -->
    <xsl:apply-templates name="Source" select="design/source"/>  <!-- Generate line .APP <eeschema version> -->
    <xsl:text>&nl;</xsl:text>

    <xsl:text>    -- Components </xsl:text>
    <xsl:text>&nl;</xsl:text>

    <xsl:text>&nl;</xsl:text>
    <xsl:apply-templates name="Component_Declaration" select="libparts/libpart"/>  <!-- Generate list of components -->

    <xsl:text>    -- Signals </xsl:text>
    <xsl:text>&nl;</xsl:text>

    <xsl:apply-templates name="Net_Declaration" select="nets/net"/>          <!-- Generate list of nets and connections -->
    <xsl:text>&nl;</xsl:text>

    <xsl:text>&nl;</xsl:text>
    <xsl:text>begin</xsl:text>
    <xsl:text>&nl;</xsl:text>

    <xsl:text>    -- Instances </xsl:text>
    <xsl:text>&nl;</xsl:text>

    <xsl:apply-templates name="Instance_Declaration" select="components/comp"/>  <!-- Generate components instances -->
    <xsl:text>&nl;</xsl:text>

    <xsl:text>&nl;</xsl:text>
    <xsl:text>end architecture rtl;&nl;</xsl:text>

</xsl:template>

 <!-- Generate line .APP "eeschema (2010-08-17 BZR 2450)-unstable" -->
<xsl:template name="Tool" match="tool">
    <xsl:text>-- --------------------------------------------------------------------</xsl:text>
    <xsl:text>&nl;</xsl:text>
    <xsl:text>-- Tool: "</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

 <!-- Generate line .TIM 20/08/2010 10:45:33 -->
<xsl:template name="Date" match="date">
    <xsl:text>-- --------------------------------------------------------------------</xsl:text>
    <xsl:text>&nl;</xsl:text>
    <xsl:text>-- Date: </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

<!-- Generate Header -->
<xsl:template name = "Source" match="source">
<xsl:text>-- --------------------------------------------------------------------</xsl:text>
<xsl:text>&nl;</xsl:text>
<xsl:text>-- File: </xsl:text>
<xsl:apply-templates/>
<xsl:text>
-- --------------------------------------------------------------------
-- Interfaces:
--      - Wishbone B4 complaint
--      - Altera Avalon Interface complaint
--
-- Module implements:
--      -
--      -
-- --------------------------------------------------------------------
-- Author:
--      PhD. Esteve Farres Berenguer
--      C / Can Planes, 6
--      ES17160 - Anglès - Girona
--      Catalonia - Spain
--
-- Contact:
--      mobile: +34 659 17 59 69
--      web: https://plus.google.com/+EsteveFarresBerenguer/posts
--      email: esteve.farres@gmail.com
--
-- --------------------------------------------------------------------
-- Code Revision History :
--      -
-- --------------------------------------------------------------------
-- Ver: | Author |Mod. Date   |Changes Made:
-- V1.0 | E.F.B. | YYYY/MM/DD | Initial ver
-- --------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity </xsl:text> <xsl:apply-templates/> <xsl:text> is
    port (
    );
</xsl:text>
<xsl:text>&nl;</xsl:text>
<xsl:text>architecture rtl of </xsl:text>
<xsl:apply-templates/>
<xsl:text> is</xsl:text>
<xsl:text>&nl;</xsl:text>
</xsl:template>


<!--
Components declaration
-->
<!-- for each component -->
<!-- create lines like
    component 74LS541 is
    port(
    );

-->
<xsl:template name="Component_Declaration" match="libpart">
    <xsl:text>    component </xsl:text>
    <xsl:value-of select="@part"/>
    <xsl:text> is </xsl:text>
    <xsl:text>&nl;</xsl:text>
    <xsl:text>    port(</xsl:text>
    <!-- close line -->
    <xsl:text>&nl;</xsl:text>
    <xsl:for-each select="pins/pin">
        <xsl:text>        signal </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> : </xsl:text>
        <xsl:choose>
            <xsl:when test = "@type = 'input' ">
                <xsl:text>in </xsl:text>
            </xsl:when>
            <xsl:when test = "@type = 'output' ">
                <xsl:text>out </xsl:text>
            </xsl:when>
            <xsl:when test = "@type = 'passive' ">
                <xsl:text>inout </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>?</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>std_logic;</xsl:text>
        <!-- close line -->
        <xsl:text>&nl;</xsl:text>
    </xsl:for-each>

    <xsl:text>    );</xsl:text>
    <!-- close line -->
    <xsl:text>&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>

</xsl:template>


<!-- for each net -->
<!-- create lines like
    signal reset std_logic;
    signal N_12 std_logic;
-->
<xsl:template name="Nets_Declaration" match="net">
    <xsl:text>    signal </xsl:text>
    <xsl:choose>
        <xsl:when test = "@name != '' ">
            <xsl:value-of select="@name"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>N_</xsl:text>
            <xsl:value-of select="@code"/>
    </xsl:otherwise>
    </xsl:choose>
    <xsl:text> : std_logic;</xsl:text>
    <xsl:text>&nl;</xsl:text>
</xsl:template>


<!--
INSTANCES
-->

<!-- for each instance -->
<!-- create lines like
    U3 : component 74LS541   (when no architecture name specified)
    port map(
    );
    U3 : component 74LS541 RTL   (with a specified architecture name)
    port map(
    );
-->
<xsl:template name="Instance_Declaration" match="comp">
    <xsl:text>    </xsl:text>
    <xsl:value-of select="@ref"/>
    <xsl:text> : component </xsl:text>
    <xsl:choose>
        <xsl:when test = "value != '' ">
            <xsl:apply-templates select="value"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>?</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <!-- close line -->
    <xsl:text>&nl;</xsl:text>

    <xsl:text>    port map(</xsl:text>
    <!-- close line -->
    <xsl:text>&nl;</xsl:text>
<!--
    search nets
-->
    <xsl:call-template name="Search_net_list" >
        <xsl:with-param name="cmp_ref" select="@ref"/>
    </xsl:call-template>
    
    <!-- close line -->
    <xsl:text>&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>

</xsl:template>





<!--
UNDER DEVELOPMENT
-->




<!--
    This template search for a net

-->
<xsl:template name="Search_net_list" >
    <xsl:param name="cmp_ref" select="0" />
    <!-- search net name in nets section and write it: -->
    <xsl:for-each select="/export/nets/net">
        <xsl:apply-templates name="Search_pin_netname" select="node">
            <xsl:with-param name="cmp_ref" select="$cmp_ref"/>
        </xsl:apply-templates>
    </xsl:for-each>
	<xsl:text>        );</xsl:text>
	<xsl:text>&nl;</xsl:text>
</xsl:template>


<!--
    This template writes )
-->

<xsl:template name="Search_pin_netname" match="node">
    <xsl:param name="cmp_ref" select="0" />
    <xsl:if test = "@ref = $cmp_ref ">


        <xsl:call-template name="Search_pin_name">
            <xsl:with-param name="cmp_ref" select="$cmp_ref"/>
            <xsl:with-param name="pin_id" select="@pin"/>
        </xsl:call-template>

		<xsl:text> => </xsl:text>

		<xsl:choose>
			<!-- if a net has a name, use it,
				else build a name from its net code
			-->
			<xsl:when test = "../@name != '' ">
				<xsl:value-of select="../@name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>N_</xsl:text><xsl:value-of select="../@code"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:text>&nl;</xsl:text>
    </xsl:if>

</xsl:template>



<!--
    This template search for 
-->
<xsl:template name="Search_pin_name" >
    <xsl:param name="cmp_ref" select="0" />
    <xsl:param name="pin_id" select="0" />
        <xsl:for-each select="//comp[@ref = $cmp_ref]">
			<xsl:call-template name="Search_lib_pin_name">
				<xsl:with-param name="cmp_ref" select="$cmp_ref"/>
				<xsl:with-param name="pin_id" select="$pin_id"/>
				<xsl:with-param name="cmplib_id" select="libsource/@part"/>
			</xsl:call-template>
        </xsl:for-each>
</xsl:template>


<!--
    This template search for a net

-->
<xsl:template name="Search_lib_pin_name" >
    <xsl:param name="cmp_ref" select="0" />
    <xsl:param name="pin_id" select="0" />
    <xsl:param name="cmplib_id" select="0" />
	
	<!-- search net name in nets section and write it: -->
	<xsl:for-each select="/export/libparts/libpart">
		<xsl:if test = "@part = $cmplib_id ">
				<xsl:for-each select="pins/pin">
					<xsl:if test = "@num=$pin_id ">
						<xsl:text>        </xsl:text>
						<xsl:value-of select="@name"/>
					</xsl:if>
				</xsl:for-each>
		</xsl:if>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
