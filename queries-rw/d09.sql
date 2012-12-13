-- QUERY 9
drop table if exists mv_q09;
create table mv_q09
	select
		p_name as mv_pname,
		n_name as mv_nation,
		extract(year from o_orderdate) as mv_o_year,
		sum(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) as mv_amount
	from
		part,
		supplier,
		lineitem,
		partsupp,
		orders,
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
		mv_o_year,
		p_name;

-- alter table mv_q09 add primary key (mv_pname, mv_nation, mv_o_year);