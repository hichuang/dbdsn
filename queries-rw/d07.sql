-- QUERY 7
drop table if exists mv_q07;
create table mv_q07
	select
		n1.n_name as mv_supp_nation,
		n2.n_name as mv_cust_nation,
		l_shipdate as mv_shipdate,
		extract(year from l_shipdate) as mv_l_year,
		l_extendedprice * (1 - l_discount) as mv_volume
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
		l_shipdate;
