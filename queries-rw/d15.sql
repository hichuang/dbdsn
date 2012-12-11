-- QUERY 15
drop table if exists mv_q15;
create table mv_q15
	select
		l_suppkey as mv_suppkey,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue,
		l_shipdate as mv_shipdate
	from
		lineitem
	group by
		l_suppkey,
		l_shipdate;