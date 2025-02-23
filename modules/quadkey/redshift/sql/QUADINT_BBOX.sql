----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADINT_BBOX
(quadint BIGINT)
RETURNS VARCHAR(MAX)
STABLE
AS $$
    from @@RS_PREFIX@@quadkeyLib import bbox
    
    if quadint is None:
        raise Exception('NULL argument passed to UDF')

    return str(bbox(quadint))
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.QUADINT_BBOX
(BIGINT)
-- (quadint)
RETURNS SUPER
STABLE
AS $$
    SELECT json_parse(@@RS_PREFIX@@carto.__QUADINT_BBOX($1))
$$ LANGUAGE sql;