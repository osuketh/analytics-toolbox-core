### ST_POLYGONIZE

{{% bannerNote type="code" %}}
carto.ST_POLYGONIZE(lines)
{{%/ bannerNote %}}

**Description**

Creates a set of polygons from geographies which contain lines that represent the their edges.

* `lines`: `ARRAY<GEOGRAPHY>` array of lines which represent the polygons edges.

**Return type**

`ARRAY<GEOGRAPHY>`

{{% customSelector %}}
**Example**
{{%/ customSelector %}}

``` sql
SELECT `carto-os`.carto.ST_POLYGONIZE([ST_GEOGFROMTEXT('LINESTRING(-74.5366825512491 43.6889777784079, -70.7632814028801 42.9679602005825, -70.2005131676838 43.8455720129728, -74.5366825512491 43.6889777784079)'), 
ST_GEOGFROMTEXT('LINESTRING(-73.9704330709753 35.3953164724094, -72.514071762468 36.5823995124737, -73.3262122666779 41.2706174323278, -73.9704330709753 35.3953164724094)')]);
-- POLYGON((-74.5366825512491 43.6889777784079, -70.7632814028801 42.9679602005825, -70.2005131676838 43.8455720129728, -74.5366825512491 43.6889777784079))
-- POLYGON((-73.9704330709753 35.3953164724094, -72.514071762468 36.5823995124737, -73.3262122666779 41.2706174323278, -73.9704330709753 35.3953164724094))
```