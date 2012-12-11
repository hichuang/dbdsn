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
