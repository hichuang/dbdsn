-- QUERY 3
drop table if exists mv_q03;
create table mv_q03
	select
		l_orderkey,
		l_extendedprice * (1 - l_discount) as mv_revenue,
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
		and l_orderkey = o_orderkey;
