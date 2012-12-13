-- The SQL to create your design will go in this file

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 1
drop table if exists mv_q01;
create table mv_q01
	select l_shipdate as mv_shipdate,
		   l_returnflag as mv_returnflag,
		   l_linestatus as mv_linestatus,
		   sum(l_quantity) as mv_sum_qty,
		   sum(l_extendedprice) as mv_sum_base_price,
		   sum(l_extendedprice * (1-l_discount)) as mv_sum_disc_price,
		   sum(l_extendedprice * (1-l_discount) * (1-l_tax)) as mv_sum_charge,
		   sum(l_discount) as mv_sum_disc,
		   count(*) as mv_count_order
	from
		lineitem
	group by
		l_returnflag,
		l_linestatus,
		l_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 2
create index part_size using HASH on part ( p_size );
create index region_name using HASH on region ( r_name );

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

alter table mv_q03 add primary key (mv_orderkey, mv_mktsegment, mv_orderdate, mv_shipdate);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 4
drop table if exists mv_q04;
create table mv_q04
	select
		o_orderpriority as mv_orderpriority,
		o_orderdate as mv_orderdate,
		count(*) as mv_order_count
	from
		orders
	where
		exists (
			select
				*
			from
				lineitem
			where
				l_orderkey = o_orderkey
				and l_commitdate < l_receiptdate
		)
	group by
		o_orderpriority,
		o_orderdate
	order by
		o_orderpriority,
		o_orderdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 5
drop table if exists mv_q05;
create table mv_q05
	select
		n_name as mv_nname,
		o_orderdate as mv_orderdate,
		r_name as mv_rname,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue
	from
		customer,
		orders,
		lineitem,
		supplier,
		nation,
		region
	where
		c_custkey = o_custkey
		and l_orderkey = o_orderkey
		and l_suppkey = s_suppkey
		and c_nationkey = s_nationkey
		and s_nationkey = n_nationkey
		and n_regionkey = r_regionkey
	group by
		r_name,
		o_orderdate,
		n_name
	order by
		mv_rname,
		mv_orderdate;

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

alter table mv_q07 add primary key (mv_supp_nation, mv_cust_nation, mv_shipdate);

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 10
drop table if exists mv_q10;
create table mv_q10
	select
		c_custkey as mv_custkey,
		c_name as mv_cname,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		c_acctbal as mv_acctbal,
		n_name as mv_nname,
		c_address as mv_addr,
		c_phone as mv_phone,
		c_comment as mv_comment,
		o_orderdate as mv_orderdate,
		l_returnflag as mv_returnflag
	from
		customer,
		orders,
		lineitem,
		nation
	where
		c_custkey = o_custkey
		and l_orderkey = o_orderkey
		and c_nationkey = n_nationkey
	group by
		l_returnflag,
		o_orderdate,
		c_custkey,
		c_name,
		c_acctbal,
		c_phone,
		n_name,
		c_address,
		c_comment;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

alter table mv_q10 add primary key (mv_custkey, mv_returnflag, mv_orderdate);

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

alter table mv_q11 add primary key (mv_nname, mv_partkey);

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

alter table mv_q12 add primary key (mv_shipmode, mv_orderprior, mv_recdate, mv_linecount);

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

alter table mv_q14 add primary key (mv_type, mv_shipdate);

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

alter table mv_q15 add primary key (mv_suppkey, mv_shipdate);

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

alter table mv_q16 add primary key (mv_brand, mv_type, mv_size, mv_suppkey);

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