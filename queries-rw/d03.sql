-- QUERY 3
drop table if exists mv_q03;
create table mv_q03
	select
		l_orderkey as mv_orderkey,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		o_orderdate as mv_orderate,
		o_shippriority as mv_shippriority
	from
		customer,
		orders,
		lineitem
	where
		c_custkey = o_custkey
		and l_orderkey = o_orderkey
	group by
		l_orderkey,
		o_orderdate,
		o_shippriority,
		o_orderdate,
		l_shipdate,
		c_mktsegment
	order by
		revenue desc,
		o_orderdate;
