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
		mv_orderdate,
		mv_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 9
drop table if exists mv_q09;
create table mv_q09
	select
		p_name as mv_pname,
		n_name as mv_nation,
		o_year as mv_o_year,
		sum(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) as mv_amount
	from
		part,
		supplier,
		lineitem,
		partsupp,
		(select o_orderkey, extract(year from o_orderdate) as o_year from orders) as torders,
		nation
	where
		s_suppkey = l_suppkey
		and ps_suppkey = l_suppkey
		and ps_partkey = l_partkey
		and p_partkey = l_partkey
		and o_orderkey = l_orderkey
		and s_nationkey = n_nationkey
	group by
		n_name,
		o_year,
		p_name;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q09 add primary key (mv_pname, mv_nation, mv_o_year);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

