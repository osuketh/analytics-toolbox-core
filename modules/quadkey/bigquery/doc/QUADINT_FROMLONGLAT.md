### QUADINT_FROMLONGLAT

{{% bannerNote type="code" %}}
carto.QUADINT_FROMLONGLAT(longitude, latitude, resolution)
{{%/ bannerNote %}}

**Description**

Returns the quadint representation for a given level of detail and geographic coordinates.

* `longitude`: `FLOAT64` horizontal coordinate of the map.
* `latitude`: `FLOAT64` vertical coordinate of the map.
* `resolution`: `INT64` level of detail or zoom.

**Return type**

`INT64`

{{% customSelector %}}
**Example**
{{%/ customSelector %}}

```sql
SELECT `carto-os`.carto.QUADINT_FROMLONGLAT(40.4168, -3.7038, 4);
-- 4388
```