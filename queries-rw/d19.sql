-- QUERY 19
drop table if exists mv_q19;
create table mv_q19 ( mv_brand CHAR(10) NOT NULL,
					  mv_container CHAR(10) NOT NULL,
					  mv_size INTEGER NOT NULL,
					  mv_qty DECIMAL(15,2) NOT NULL,
					  mv_shipmode CHAR(10) NOT NULL,
					  mv_shipinstruct CHAR(25) NOT NULL,
					  mv_revenue DECIMAL(15,4) NOT NULL,
					  primary key(mv_brand, mv_size, mv_size, mv_qty, mv_shipmode, mv_shipinstruct) );

insert into mv_q19 (mv_brand, mv_container, mv_size, mv_qty, mv_shipmode, mv_shipinstruct, mv_revenue)
	select
		p_brand,
		p_container,
		p_size,
		l_quantity,
		l_shipmode,
		l_shipinstruct,
		sum(l_extendedprice * (1 - l_discount))
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
