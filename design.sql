-- The SQL to create your design will go in this file

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 3
drop table if exists mv_q03;
create table mv_q03
	select
		l_orderkey as mv_orderkey,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		o_orderdate as mv_orderdate,
		o_shippriority as mv_shippriority,
		l_shipdate as mv_shipdate,
		c_mktsegment as mv_mktsegment
	from
		customer,
		orders,
		lineitem
	where
		c_custkey = o_custkey
		and l_orderkey = o_orderkey
	group by
		c_mktsegment,
		l_orderkey,
		o_orderdate,
		o_shippriority,
		l_shipdate
	order by
		mv_mktsegment,
		mv_orderkey,
		mv_orderdate,
		mv_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q03 add primary key (mv_mktsegment, mv_orderkey, mv_orderdate, mv_shipdate);

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
		sum(l_extendedprice * (1 - l_discount)) as mv_volumn
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
		nation,
		o_year;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q08 add primary key (mv_name, mv_orderdate, mv_type, mv_nation);
alter table mv_q08 modify mv_o_year integer;
alter table mv_q08 modify mv_nation varchar(25);
alter table mv_q08 modify mv_volume decimal(10, 4);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 19
drop table if exists mv_q19;
create table mv_q19
	select
		p_brand as mv_brand,
		p_container as mv_container,
		p_size as mv_size,
		l_quantity as mv_qty,
		l_shipmode as mv_shipmode,
		l_shipinstruct as mv_shipinstruct,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue
	from
		lineitem,
		part
	where
		p_partkey = l_partkey
	group by
		p_brand,
		p_container,
		p_size,
		l_quantity,
		l_shipmode, 
		l_shipinstruct
	order by
		mv_brand,
		mv_container,
		mv_size,
		mv_qty,
		mv_shipmode,
		mv_shipinstruct;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q19 add primary key (mv_brand, mv_container, mv_size, mv_qty, mv_shipmode, mv_shipinstruct);
alter table mv_19 modify mv_revenue decimal(10, 4);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;
