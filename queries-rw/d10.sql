-- QUERY 10
drop table if exists mv_q10_l;
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
		c_custkey,
		c_name,
		c_acctbal,
		c_phone,
		n_name,
		c_address,
		c_comment,
		o_orderdate,
		l_returnflag