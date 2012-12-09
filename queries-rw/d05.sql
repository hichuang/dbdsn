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
