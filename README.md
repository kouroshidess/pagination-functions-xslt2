# Pagination functions (XSLT 2.0)
XSLT approach that helps custmoise and create pagination items simialr to the ones offered by Bootstrap pagination component. 
http://getbootstrap.com/components/#pagination

```
<xsl:function name="p:list" as="element(ul)">
    <xsl:param name="offset"/>
    <xsl:param name="limit"/>
    <xsl:param name="count"/>
    <!-- ... -->
</xsl:function>

<!-- ... -->

<xsl:sequence select="p:list(0, 10, 100)"/>

<!-- ... -->

<ul>
   <li class="disabled">
      <a href="#">Previous</a>
   </li>
   <li class="disabled highlight">
      <a href="#">1</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=10">2</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=20">3</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=30">4</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=40">5</a>
   </li>
   <li class="disabled">
      <a href="#">…</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=90">10</a>
   </li>
   <li>
      <a href="http://localhost/table.html?offset=10">Next</a>
   </li>
</ul>
```
