### PLACEKEY_ISVALID

{{% bannerNote type="code" %}}
carto.PLACEKEY_ISVALID(placekey)
{{%/ bannerNote %}}

**Description**

Returns a boolean value `true` when the given string represents a valid Placekey, `false` otherwise.

* `placekey`: `VARCHAR` Placekey identifier.

**Return type**

`BOOLEAN`

**Examples**

```sql
SELECT carto.PLACEKEY_ISVALID('@ff7-swh-m49');
-- true
```

```sql
SELECT carto.PLACEKEY_ISVALID('ff7-swh-m49');
-- true
```

```sql
SELECT carto.PLACEKEY_ISVALID('x');
-- false
```