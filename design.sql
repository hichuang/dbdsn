-- The SQL to create your design will go in this file

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;
-- QUERY 6
drop table if exists mv_q06;
create table mv_q06
	select
		sum(l_extendedprice * l_discount) as mv_revenue,
		l_shipdate as mv_shipdate,
		l_discount as mv_disc,
		l_quantity as mv_qty
	from
		lineitem
	group by
		l_quantity,
		l_discount,
		l_shipdate
	order by
		mv_qty,
		mv_disc,
		l_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 7
drop table if exists mv_q07;
create table mv_q07
	select
		n1.n_name as mv_supp_nation,
		n2.n_name as mv_cust_nation,
		l_shipdate as mv_shipdate,
		extract(year from l_shipdate) as mv_l_year,
		sum(l_extendedprice * (1 - l_discount)) as mv_volume
	from
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2
	where
		s_suppkey = l_suppkey
		and o_orderkey = l_orderkey
		and c_custkey = o_custkey
		and s_nationkey = n1.n_nationkey
		and c_nationkey = n2.n_nationkey
	group by
		n1.n_name,
		n2.n_name,
		l_shipdate
	order by
		mv_supp_nation,
		mv_cust_nation;

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

-- QUERY 11
drop table if exists mv_q11;
create table mv_q11
	select 
		ps_partkey as mv_partkey,
		sum(ps_supplycost * ps_availqty) as mv_value,
		n_name as mv_nname
	from
		partsupp,
		supplier,
		nation
	where
		ps_suppkey = s_suppkey
		and s_nationkey = n_nationkey
	group by
		ps_partkey,
		n_name
	order by
		mv_nname;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 12
drop table if exists mv_q12;
create table mv_q12
	select
		l_shipmode as mv_shipmode,
		o_orderpriority as mv_orderprior,
		l_receiptdate as mv_recdate,
		count(*) as mv_linecount
	from
		orders,
		lineitem
	where
		o_orderkey = l_orderkey
		and l_commitdate < l_receiptdate
		and l_shipdate < l_commitdate
	group by
		l_shipmode,
		o_orderpriority,
		l_receiptdate
	order by
		mv_shipmode,
		mv_orderprior,
		mv_recdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 14
drop table if exists mv_q14;
create table mv_q14
	select
		p_type as mv_type,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		l_shipdate as mv_shipdate
	from
		lineitem,
		part
	where
		l_partkey = p_partkey
	group by
		p_type,
		l_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 15
drop table if exists mv_q15;
create table mv_q15
	select
		l_suppkey as mv_suppkey,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		l_shipdate as mv_shipdate
	from
		lineitem
	group by
		l_suppkey,
		l_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 16
drop table if exists mv_q16;
create table mv_q16
	select
		p_brand as mv_brand,
		p_type as mv_type,
		p_size as mv_size,
		s_comment as mv_comment,
		ps_suppkey as mv_suppkey
	from
		partsupp,
		part,
		supplier
	where
		p_partkey = ps_partkey
		and ps_suppkey = s_suppkey
	group by
		p_brand,
		p_type,
		p_size,
		s_comment,
		ps_suppkey;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 21
drop table if exists mv_q21;
create table mv_q21
	select
		s_name as mv_sname,
		count(*) as mv_numwait,
		o_orderstatus as mv_orderstat,
		n_name as mv_nname
	from
		supplier,
		lineitem l1,
		orders,
		nation
	where
		s_suppkey = l1.l_suppkey
		and o_orderkey = l1.l_orderkey
		and l1.l_receiptdate > l1.l_commitdate
		and exists (
			select
				*
			from
				lineitem l2
			where
				l2.l_orderkey = l1.l_orderkey
				and l2.l_suppkey <> l1.l_suppkey
		)
		and not exists (
			select
				*
			from
				lineitem l3
			where
				l3.l_orderkey = l1.l_orderkey
				and l3.l_suppkey <> l1.l_suppkey
				and l3.l_receiptdate > l3.l_commitdate
		)
		and s_nationkey = n_nationkey
	group by
		o_orderstatus,
		n_name,
		s_name;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;
