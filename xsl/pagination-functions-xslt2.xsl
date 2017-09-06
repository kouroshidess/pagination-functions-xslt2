<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:p="pagination"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  exclude-result-prefixes="#all">

  <xsl:param name="prev" as="xs:string">Previous</xsl:param>
  <xsl:param name="next" as="xs:string">Next</xsl:param>
  <xsl:param name="omission" as="xs:string">…</xsl:param>
  <xsl:param name="base" as="xs:string?"
    >http://localhost/table.html?offset=</xsl:param>

  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="/" name="main">
    <xsl:sequence select="p:list(0, 10, 100)"/>
  </xsl:template>

  <xsl:function name="p:list" as="element(ul)">
    <xsl:param name="offset"/>
    <xsl:param name="limit"/>
    <xsl:param name="count"/>

    <xsl:variable name="label"
      select="p:range($offset, $limit, $count, 'label')"/>
    <xsl:variable name="enabled"
      select="p:range($offset, $limit, $count, 'enabled')"/>
    <xsl:variable name="current"
      select="p:range($offset, $limit, $count, 'current')"/>

    <ul>
      <xsl:for-each select="1 to count($label)">
        <xsl:variable name="i" select="."/>
        <xsl:variable name="class"
          select="
          if ($enabled[$i] eq 'true') then () else 'disabled',
          if ($current[$i] eq 'true') then 'highlight' else ()
          "/>
        <xsl:variable name="href">
          <xsl:choose>
            <xsl:when test="$enabled[$i] = 'false'">#</xsl:when>
            <xsl:when test="matches($label[$i], '^\d+$')">
              <xsl:value-of
                select="concat($base, xs:integer($label[$i]) * $limit - $limit)"
              />
            </xsl:when>
            <xsl:when test="$label[$i] eq $prev">
              <xsl:value-of select="concat($base, $offset - $limit)"/>
            </xsl:when>
            <xsl:when test="$label[$i] eq $next">
              <xsl:value-of select="concat($base, $offset + $limit)"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        <li>
          <xsl:if test="exists($class[normalize-space()])">
            <xsl:attribute name="class" select="$class"/>
          </xsl:if>
          <a href="{$href}">
            <xsl:sequence select="$label[$i]"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:function>

  <xsl:function name="p:range" as="xs:string+">
    <xsl:param name="offset" as="xs:integer"/>
    <xsl:param name="limit" as="xs:integer"/>
    <xsl:param name="count" as="xs:integer"/>
    <xsl:param name="key"/>

    <xsl:variable name="current" as="xs:integer"
      select="($offset + $limit) div $limit"/>
    <xsl:variable name="last" as="xs:integer" select="$count div $limit"/>
    <xsl:variable name="range" as="item()+">
      <xsl:choose>
        <xsl:when test="$current lt 5">
          <xsl:sequence select="$prev, 1 to 5, $omission, $last, $next"/>
        </xsl:when>
        <xsl:when test="$current gt $last -4">
          <xsl:sequence select="$prev, 1, $omission, $last -4 to $last, $next"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence
            select="$prev, 1, $omission, $current -1 to $current +1, $omission, $last, $next"
          />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="map" as="element(map)">
      <map>
        <xsl:for-each select="$range">
          <map-entry key="position()">
            <map>
              <map-entry key="label">
                <xsl:value-of select="current()"/>
              </map-entry>
              <map-entry key="enabled">
                <xsl:choose>
                  <xsl:when test="string(.) = (string($current), $omission)"
                    >false</xsl:when>
                  <xsl:when test="string(.) eq $prev and $current eq 1"
                    >false</xsl:when>
                  <xsl:when test="string(.) eq $next and $current eq $last"
                    >false</xsl:when>
                  <xsl:otherwise>true</xsl:otherwise>
                </xsl:choose>
              </map-entry>
              <map-entry key="current">
                <xsl:choose>
                  <xsl:when test="string(.) eq string($current)">true</xsl:when>
                  <xsl:otherwise>false</xsl:otherwise>
                </xsl:choose>
              </map-entry>
            </map>
          </map-entry>
        </xsl:for-each>
      </map>
    </xsl:variable>

    <xsl:variable name="void" as="xs:string*" select="map:keys($map)"/>
    <xsl:variable name="void" as="element(map)*" select="map:get($map, $void)"/>
    <xsl:variable name="void" as="item()*"
      select="for $i in $void return map:get($i, $key)"/>

    <xsl:sequence select="$void"/>

  </xsl:function>

  <xsl:function name="p:info" as="xs:string">
    <xsl:param name="offset"/>
    <xsl:param name="limit"/>
    <xsl:param name="count"/>

    <xsl:value-of
      select="
      'Showing', 
      format-number($offset + 1, '#,###'),
      'to', 
      format-number($offset + $limit, '#,###'),
      'of', 
      format-number($count, '#,###'), 
      'entries'"/>

  </xsl:function>

  <xsl:function name="map:keys" as="item()*">
    <xsl:param name="map" as="element(map)"/>

    <xsl:sequence select="$map/map-entry/@key"/>

  </xsl:function>

  <xsl:function name="map:get" as="item()*">
    <xsl:param name="map" as="element(map)"/>
    <xsl:param name="key" as="item()*"/>

    <xsl:sequence select="$map/map-entry[@key = $key]/node()"/>

  </xsl:function>

</xsl:stylesheet>
