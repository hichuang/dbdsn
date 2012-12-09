-- QUERY 4
select
	mv_orderpriority as o_orderpriority,
	sum(mv_order_count) as order_count
from
	mv_q04
where
	mv_orderdate >= date '1993-07-01'
	and mv_orderdate < date '1993-07-01' + interval '3' month
group by
	mv_orderpriority
order by
	o_orderpriority;