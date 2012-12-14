-- QUERY 19
create table mv_q19
	select
		p_brand as mv_brand,
		p_container as mv_container,
		p_size as mv_size,
		l_quantity as mv_qty,
		l_shipmode as mv_shipmode,
		l_shipinstruct as mv_shipinstruct,
		sum(l_extendedprice * (1 - l_discount)) as mv_revenue
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
		l_shipinstruct
	order by
		mv_brand,
		mv_container,
		mv_size,
		mv_qty,
		mv_shipmode,
		mv_shipinstruct;

alter table mv_q19 add primary key (mv_brand, mv_container, mv_size, mv_qty, mv_shipmode, mv_shipinstruct);
alter table mv_19 modify mv_revenue decimal(10, 4);
