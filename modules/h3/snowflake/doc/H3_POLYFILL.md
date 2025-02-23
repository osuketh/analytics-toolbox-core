### H3_POLYFILL

{{% bannerNote type="code" %}}
carto.H3_POLYFILL(geography, resolution)
{{%/ bannerNote %}}

**Description**

Returns an array with all the H3 cell indexes **with centers** contained in a given polygon. It will return `null` on error (invalid geography type or resolution out of bounds).

* `geography`: `GEOGRAPHY` **polygon** or **multipolygon** representing the area to cover.
* `resolution`: `INT` number between 0 and 15 with the [H3 resolution](https://h3geo.org/docs/core-library/restable).

**Return type**

`ARRAY`

**Example**

```sql
SELECT carto.H3_POLYFILL(
    TO_GEOGRAPHY('POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))'), 4);
-- 842da29ffffffff
-- 843f725ffffffff
-- 843eac1ffffffff
-- 8453945ffffffff
-- ...
```