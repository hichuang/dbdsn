-- The SQL to create your design will go in this file

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 8
drop table if exists mv_q08;
create table mv_q08
	select 
		extract(year from o_orderdate) as mv_o_year,
		n2.n_name as mv_nation,
		r_name as mv_rname,
		o_orderdate as mv_orderdate,
		p_type as mv_type,
		sum(l_extendedprice * (1 - l_discount)) as mv_volume
	from 
		part,
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2,
		region
	where
		p_partkey = l_partkey
		and s_suppkey = l_suppkey
		and l_orderkey = o_orderkey
		and o_custkey = c_custkey
		and c_nationkey = n1.n_nationkey
		and n1.n_regionkey = r_regionkey
		and s_nationkey = n2.n_nationkey
	group by
		r_name,
		o_orderdate,
		p_type,
		mv_nation,
		mv_o_year
	order by
		mv_rname,
		mv_orderdate,
		mv_type,
		mv_nation;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q08 add primary key (mv_name, mv_orderdate, mv_type, mv_nation);
alter table mv_q08 modify mv_o_year integer;
alter table mv_q08 modify mv_nation varchar(25);
alter table mv_q08 modify mv_volume decimal(10, 4);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;
