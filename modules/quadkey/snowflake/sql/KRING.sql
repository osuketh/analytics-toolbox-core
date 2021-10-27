----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION _KRING
(origin STRING, size DOUBLE)
RETURNS ARRAY
LANGUAGE JAVASCRIPT
AS $$
    @@SF_LIBRARY_CONTENT@@

    if (ORIGIN == null || ORIGIN <= 0) {
        throw new Error('Invalid input origin')
    }

    if (SIZE == null || SIZE < 0) {
        throw new Error('Invalid input size')
    }

    return quadkeyLib.kRing(ORIGIN, parseInt(SIZE));
$$;

CREATE OR REPLACE SECURE FUNCTION KRING
(origin BIGINT, size INT)
RETURNS ARRAY
AS $$
    _KRING(CAST(ORIGIN AS STRING), CAST(SIZE AS DOUBLE))
$$;