----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.QUADINT_FROMGEOGPOINT
(GEOMETRY, INT)
-- (point, resolution)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.QUADINT_FROMLONGLAT(ST_X($1), ST_Y($1), $2)
$$ LANGUAGE sql;