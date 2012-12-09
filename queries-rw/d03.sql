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
		l_orderkey,
		o_orderdate,
		o_shippriority,
		o_orderdate,
		l_shipdate,
		c_mktsegment
	order by
		mv_mktsegment,
		mv_orderdate,
		mv_shipdate,

-- create index mktsegment on mv_q03( mv_mktsegment );
