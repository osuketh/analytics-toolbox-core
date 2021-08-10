----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@quadkey.ST_BOUNDARY`(quadint INT64)
RETURNS GEOGRAPHY
AS (
    COALESCE(
        ST_MAKEPOLYGON(
            ST_MAKELINE([
                ST_GEOGPOINT(
                    `@@BQ_PREFIX@@quadkey.__BBOX_E`(quadint),
                    `@@BQ_PREFIX@@quadkey.__BBOX_N`(quadint)),
                ST_GEOGPOINT(
                    `@@BQ_PREFIX@@quadkey.__BBOX_E`(quadint),
                    `@@BQ_PREFIX@@quadkey.__BBOX_S`(quadint)),
                ST_GEOGPOINT(
                    `@@BQ_PREFIX@@quadkey.__BBOX_W`(quadint),
                    `@@BQ_PREFIX@@quadkey.__BBOX_S`(quadint)),
                ST_GEOGPOINT(
                    `@@BQ_PREFIX@@quadkey.__BBOX_W`(quadint),
                    `@@BQ_PREFIX@@quadkey.__BBOX_N`(quadint)),
                ST_GEOGPOINT(
                    `@@BQ_PREFIX@@quadkey.__BBOX_E`(quadint),
                    `@@BQ_PREFIX@@quadkey.__BBOX_N`(quadint))
                ])
            ),
        ERROR('NULL argument passed to UDF')
    )
);