----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION _AZIMUTH
(geojsonStart STRING, geojsonEnd STRING)
RETURNS DOUBLE
LANGUAGE JAVASCRIPT
AS $$
    @@SF_LIBRARY_CONTENT@@

    if (!GEOJSONSTART || !GEOJSONEND) {
        return null;
    }
    return measurementsLib.bearing(JSON.parse(GEOJSONSTART), JSON.parse(GEOJSONEND));
$$;

CREATE OR REPLACE SECURE FUNCTION ST_AZIMUTH
(startPoint GEOGRAPHY, endPoint GEOGRAPHY)
RETURNS DOUBLE
AS $$
    _AZIMUTH(CAST(ST_ASGEOJSON(STARTPOINT) AS STRING), CAST(ST_ASGEOJSON(ENDPOINT) AS STRING))
$$;
