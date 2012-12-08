-- QUERY 1
drop table if exists mv_q01;
create table mv_q01
	select mv_returnflag,
		   mv_linestatus,
		   mv_shipdate,
		   sum(l_quantity) as mv_sum_qty,
		   sum(l_extendedprice) as mv_sum_base_price,
		   sum(l_extendedprice * (1-l_discount)) as mv_sum_disc_price,
		   sum(l_extendedprice * (1-l_discount) * (1-l_tax)) as mv_sum_charge,
		   sum(l_discount) as mv_sum_disc,
		   count(*) as mv_count_order
	from
		lineitem
	group by
		l_returnflag,
		l_linestatus,
		l_shipdate;
