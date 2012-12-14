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
		l_shipdate