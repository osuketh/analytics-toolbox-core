----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE SECURE FUNCTION H3_ISPENTAGON
(index STRING)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
IMMUTABLE
AS $$
    if (!INDEX) {
        return false;
    }

    @@SF_LIBRARY_ISPENTAGON@@

    return h3Lib.h3IsPentagon(INDEX);
$$;