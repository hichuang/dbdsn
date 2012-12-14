-- The SQL to create your design will go in this file

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 3
drop table if exists mv_q03;
create table mv_q03 ( mv_orderkey INTEGER NOT NULL,
					  mv_revenue DECIMAL(15,4) NOT NULL,
					  mv_orderdate DATE NOT NULL,
					  mv_shipdate DATE NOT NULL,
					  mv_shippriority INTEGER NOT NULL,
					  mv_mktsegment CHAR(10) NOT NULL,
					  primary key (mv_orderkey, mv_mktsegment, mv_orderdate, mv_shipdate) );

insert into mv_q03 (mv_orderkey, mv_revenue, mv_orderdate, mv_shippriority, mv_shipdate, mv_mktsegment)	
	select
		l_orderkey,
		sum(l_extendedprice * (1 - l_discount)),
		o_orderdate,
		o_shippriority,
		l_shipdate,
		c_mktsegment
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
		l_shipdate;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 8
drop table if exists mv_q08;
create table mv_q08 ( mv_o_year INTEGER NOT NULL,
					  mv_nation CHAR(25) NOT NULL,
					  mv_rname CHAR(25) NOT NULL,
					  mv_orderdate DATE NOT NULL,
					  mv_type VARCHAR(25) NOT NULL,
					  mv_volumn DECIMAL(15,4) NOT NULL ); 

insert into mv_q08 (mv_o_year, mv_nation, mv_rname, mv_orderdate, mv_type, mv_volumn)
	select 
		extract(year from o_orderdate) as o_year,
		n2.n_name as nation,
		r_name,
		o_orderdate,
		p_type,
		sum(l_extendedprice * (1 - l_discount))
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
		o_year,
		nation,
		r_name,
		o_orderdate,
		p_type;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;

-- QUERY 19
drop table if exists mv_q19;
create table mv_q19 ( mv_brand CHAR(10) NOT NULL,
					  mv_container CHAR(10) NOT NULL,
					  mv_size INTEGER NOT NULL,
					  mv_qty DECIMAL(15,2) NOT NULL,
					  mv_shipmode CHAR(10) NOT NULL,
					  mv_shipinstruct CHAR(25) NOT NULL,
					  mv_revenue DECIMAL(15,4) NOT NULL,
					  primary key(mv_brand, mv_size, mv_size, mv_qty, mv_shipmode, mv_shipinstruct) );

insert into mv_q19 (mv_brand, mv_container, mv_size, mv_qty, mv_shipmode, mv_shipinstruct, mv_revenue)
	select
		p_brand,
		p_container,
		p_size,
		l_quantity,
		l_shipmode,
		l_shipinstruct,
		sum(l_extendedprice * (1 - l_discount))
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
		l_shipinstruct;

select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB" from information_schema.TABLES where table_schema = "tpch" group by table_schema;
