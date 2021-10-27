----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION _GEOJSONBOUNDARY_FROMQUADINT
(quadint STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
AS $$
    @@SF_LIBRARY_CONTENT@@
    
    if (!QUADINT) {
        throw new Error('NULL argument passed to UDF');
    }

    const geojson = quadkeyLib.quadintToGeoJSON(QUADINT);
    return JSON.stringify(geojson);
$$;

CREATE OR REPLACE SECURE FUNCTION ST_BOUNDARY
(quadint BIGINT)
RETURNS GEOGRAPHY
AS $$
    TRY_TO_GEOGRAPHY(_GEOJSONBOUNDARY_FROMQUADINT(CAST(QUADINT AS STRING)))
$$;