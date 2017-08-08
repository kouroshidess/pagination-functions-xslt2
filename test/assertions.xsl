<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:p="pagination" xmlns:functx="http://www.functx.com">

  <xsl:import href="../xsl/pagination-functions-xslt2.xsl"/>

  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="/" name="main">

    <xsl:call-template name="p:list"/>
    <xsl:call-template name="p:range-label"/>
    <xsl:call-template name="p:range-enabled"/>
    <xsl:call-template name="p:range-enabled"/>
    <xsl:call-template name="p:range-count"/>
    <xsl:call-template name="p:info"/>

  </xsl:template>

  <xsl:template name="p:list">

    <xsl:variable name="expected">
      <ul>
        <li class="disabled">
          <a href="#">Previous</a>
        </li>
        <li class="disabled highlight">
          <a href="#">1</a>
        </li>
        <li>
          <a href="{$base}10">2</a>
        </li>
        <li>
          <a href="{$base}20">3</a>
        </li>
        <li>
          <a href="{$base}30">4</a>
        </li>
        <li>
          <a href="{$base}40">5</a>
        </li>
        <li class="disabled">
          <a href="#">
            <xsl:value-of select="$omission"/>
          </a>
        </li>
        <li>
          <a href="{$base}90">10</a>
        </li>
        <li>
          <a href="{$base}10">Next</a>
        </li>
      </ul>
    </xsl:variable>
    <xsl:variable name="result">
      <xsl:sequence select="p:list(0, 10, 100)"/>
    </xsl:variable>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected">
      <ul>
        <li>
          <a href="{$base}40">Previous</a>
        </li>
        <li>
          <a href="{$base}0">1</a>
        </li>
        <li class="disabled">
          <a href="#">
            <xsl:value-of select="$omission"/>
          </a>
        </li>
        <li>
          <a href="{$base}40">5</a>
        </li>
        <li class="disabled highlight">
          <a href="#">6</a>
        </li>
        <li>
          <a href="{$base}60">7</a>
        </li>
        <li class="disabled">
          <a href="#">
            <xsl:value-of select="$omission"/>
          </a>
        </li>
        <li>
          <a href="{$base}90">10</a>
        </li>
        <li>
          <a href="{$base}60">Next</a>
        </li>
      </ul>
    </xsl:variable>
    <xsl:variable name="result">
      <xsl:sequence select="p:list(50, 10, 100)"/>
    </xsl:variable>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected">
      <ul>
        <li>
          <a href="{$base}80">Previous</a>
        </li>
        <li>
          <a href="{$base}0">1</a>
        </li>
        <li class="disabled">
          <a href="#">
            <xsl:value-of select="$omission"/>
          </a>
        </li>
        <li>
          <a href="{$base}50">6</a>
        </li>
        <li>
          <a href="{$base}60">7</a>
        </li>
        <li>
          <a href="{$base}70">8</a>
        </li>
        <li>
          <a href="{$base}80">9</a>
        </li>
        <li class="disabled highlight">
          <a href="#">10</a>
        </li>
        <li class="disabled">
          <a href="#">Next</a>
        </li>
      </ul>
    </xsl:variable>
    <xsl:variable name="result">
      <xsl:sequence select="p:list(90, 10, 100)"/>
    </xsl:variable>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

  </xsl:template>

  <xsl:template name="p:range-label">

    <xsl:variable name="expected"
      select="'Previous', '1', '2', '3', '4', '5', $omission, '10', 'Next'"/>
    <xsl:variable name="result" select="p:range(0, 10, 100, 'label')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected"
      select="'Previous', '1', $omission, '5', '6', '7', $omission, '10', 'Next'"/>
    <xsl:variable name="result" select="p:range(50, 10, 100, 'label')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected"
      select="'Previous', '1', $omission, '6', '7', '8', '9', '10', 'Next'"/>
    <xsl:variable name="result" select="p:range(90, 10, 100, 'label')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

  </xsl:template>

  <xsl:template name="p:range-enabled">

    <xsl:variable name="expected"
      select="'false', 'false', 'true', 'true', 'true', 'true', 'false', 'true', 'true'"/>
    <xsl:variable name="result" select="p:range(0, 10, 100, 'enabled')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$result, $expected"
      /></xsl:assert>

    <xsl:variable name="expected"
      select="'true', 'true', 'false', 'true', 'false', 'true', 'false', 'true', 'true'"/>
    <xsl:variable name="result" select="p:range(50, 10, 100, 'enabled')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected"
      select="'true', 'true', 'false', 'true', 'true', 'true', 'true', 'false', 'false'"/>
    <xsl:variable name="result" select="p:range(90, 10, 100, 'enabled')"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

  </xsl:template>

  <xsl:template name="p:range-count">

    <xsl:variable name="expected" select="9"/>
    <xsl:variable name="result" select="count(p:range(0, 10, 100, 'label'))"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

  </xsl:template>

  <xsl:template name="p:info">

    <xsl:variable name="expected" select="'Showing 1 to 10 of 100 entries'"/>
    <xsl:variable name="result" select="p:info(0, 10, 100)"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected" select="'Showing 51 to 60 of 100 entries'"/>
    <xsl:variable name="result" select="p:info(50, 10, 100)"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

    <xsl:variable name="expected" select="'Showing 91 to 100 of 100 entries'"/>
    <xsl:variable name="result" select="p:info(90, 10, 100)"/>
    <xsl:assert test="functx:sequence-deep-equal($result, $expected)"
      select="$result"> != <xsl:sequence select="$expected"/></xsl:assert>

  </xsl:template>

</xsl:stylesheet>
