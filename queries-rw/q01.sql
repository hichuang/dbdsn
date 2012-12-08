-- QUERY 1
select
	mv_returnflag as l_returnflag,
	mv_linestatus as l_linestatus,
	sum(mv_sum_qty) as sum_qty,
	sum(mv_sum_base_price) as sum_base_price,
	sum(mv_sum_disc_price) as sum_disc_price,
	sum(mv_sum_charge) as sum_charge,
	sum(mv_sum_qty) / sum(mv_count_order) as avg_qty,
	sum(mv_sum_base_price) / sum(mv_count_order) as avg_price,
	sum(mv_sum_disc) / sum(mv_count_order) as avg_disc,
	sum(mv_count_order) as count_order
from
	mv_q01
where
	mv_shipdate <= date '1998-12-01'
group by
	mv_returnflag,
	mv_linestatus
order by
	mv_returnflag,
	mv_linestatus;