-- QUERY 10
drop table if exists mv_q10_l;
create table mv_q10_l
	select
		l_orderkey, l_extendedprice, l_discount, l_returnflag
	from 
		lineitem
	order by
		l_returnflag;


