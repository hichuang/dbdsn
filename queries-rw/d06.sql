-- QUERY 6
drop table if exists mv_q06;
create table mv_q06
	select
		sum(l_extendedprice * l_discount) as mv_revenue,
		l_shipdate as mv_shipdate,
		l_discount as mv_disc,
		l_quantity as mv_qty
	from
		lineitem
	group by
		l_shipdate,
		l_discount,
		l_quantity;