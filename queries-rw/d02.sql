-- QUERY 2
create index part_size using HASH on part ( p_size );
create index region_name using HASH on region ( r_name );