-- QUERY 19
drop table if exists mv_q19;
create table mv_q19
	select
		p_brand,
		p_container,
		p_size,
		l_quantity,
		l_shipmode,
		l_shipinstruct,
		sum(l_extendedprice * (1 - l_discount)) as revenue
	from
		lineitem,
		part
	where
		p_partkey = l_partkey
	group by
		p_brand,
		p_container,
		p_size,
		l_quantity,
		l_shipmode,
		l_shipinstruct;
