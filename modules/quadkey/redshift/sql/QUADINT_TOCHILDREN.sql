----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADINT_TOCHILDREN
(quadint BIGINT, resolution INT)
RETURNS VARCHAR(MAX)
STABLE
AS $$
    from @@RS_PREFIX@@quadkeyLib import to_children
    
    if quadint is None or resolution is None:
        raise Exception('NULL argument passed to UDF')

    return str(to_children(quadint, resolution))
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.QUADINT_TOCHILDREN
(BIGINT, INT)
-- (quadint, resolution)
RETURNS SUPER
STABLE
AS $$
    SELECT json_parse(@@RS_PREFIX@@carto.__QUADINT_TOCHILDREN($1, $2))
$$ LANGUAGE sql;