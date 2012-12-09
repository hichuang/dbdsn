-- QUERY 2
create index part_size using HASH on part ( p_size );
create index region_name on using HASH on region ( r_name );