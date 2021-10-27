----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

USE role ACCOUNTADMIN;
USE @@SF_DATABASE@@;

CREATE SHARE IF NOT EXISTS @@SF_SHARE@@;
grant usage on database @@SF_DATABASE@@ to share @@SF_SHARE@@;
grant usage on schema @@SF_DATABASE@@.@@SF_SCHEMA@@ to share @@SF_SHARE@@;

grant usage on function ST_CENTERMEAN(GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function ST_CENTERMEDIAN(GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function ST_CENTEROFMASS(GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function ST_CONCAVEHULL(ARRAY) to share @@SF_SHARE@@;
grant usage on function ST_CONCAVEHULL(ARRAY, DOUBLE) to share @@SF_SHARE@@;
grant usage on function ST_CONCAVEHULL(ARRAY, DOUBLE, STRING) to share @@SF_SHARE@@;
grant usage on function ST_DESTINATION(GEOGRAPHY, DOUBLE, DOUBLE) to share @@SF_SHARE@@;
grant usage on function ST_DESTINATION(GEOGRAPHY, DOUBLE, DOUBLE, STRING) to share @@SF_SHARE@@;
grant usage on function ST_GREATCIRCLE(GEOGRAPHY, GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function ST_GREATCIRCLE(GEOGRAPHY, GEOGRAPHY, INT) to share @@SF_SHARE@@;
grant usage on function ST_LINE_INTERPOLATE_POINT(GEOGRAPHY, DOUBLE) to share @@SF_SHARE@@;
grant usage on function ST_LINE_INTERPOLATE_POINT(GEOGRAPHY, DOUBLE, STRING) to share @@SF_SHARE@@;
grant usage on function VERSION() to share @@SF_SHARE@@;