----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION _QUADINT_FROMQUADKEY
(quadkey STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
IMMUTABLE
AS $$
    @@SF_LIBRARY_CONTENT@@

    return quadkeyLib.quadintFromQuadkey(QUADKEY).toString();
$$;

CREATE OR REPLACE SECURE FUNCTION QUADINT_FROMQUADKEY
(quadkey STRING)
RETURNS BIGINT
IMMUTABLE
AS $$
    CAST(_QUADINT_FROMQUADKEY(QUADKEY) AS BIGINT)
$$;