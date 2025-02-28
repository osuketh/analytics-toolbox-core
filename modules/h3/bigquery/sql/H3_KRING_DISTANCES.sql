----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@carto.H3_KRING_DISTANCES`
(origin STRING, size INT64)
RETURNS ARRAY<STRUCT<index STRING, distance INT64>>
DETERMINISTIC
LANGUAGE js
OPTIONS (library=["@@BQ_LIBRARY_BUCKET@@"])
AS """
    if (!h3Lib.h3IsValid(origin)) {
        throw new Error('Invalid input origin')
    }
    if (size == null || size < 0) {
        throw new Error('Invalid input size')
    }
    const kringDistances = h3Lib.kRingDistances(origin, size);
    const output = [];
    for (let distance = 0; distance <= size; distance++) {
        const indexes = kringDistances[distance];
        for (const index of indexes) {
            output.push({ index, distance });
        }
    }
    return output;
""";