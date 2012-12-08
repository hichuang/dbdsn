-- QUERY 1
/*drop table if exists mv_q01;
create table mv_q01
	select l_returnflag,
		   l_linestatus,
		   l_shipdate,
		   sum(l_quantity) as sum_qty
		   sum(l_extendedprice) as sum_base_price
		   sum(l_extendedprice * (1-l_discount)) as sum_disc_price,
		   sum(l_extendedprice * (1-l_discount) * (1-l_tax)) as sum_charge,
		   sum(l_discount) as sum_disc,
		   count(*) as count_order
	from
		lineitem
	group by
		l_returnflag,
		l_linestatus,
		l_shipdate;*/
DROP INDEX shipdate ON lineitem;
CREATE INDEX shipdate ON lineitem( l_shipdate );