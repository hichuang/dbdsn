-- QUERY 6
select
	sum(mv_revenue) as revenue
from
	mv_q06
where
	mv_qty < 24
	and mv_disc between .06 - 0.01 and .06 + 0.01
	and mv_shipdate >= date '1994-01-01'
	and mv_shipdate < date '1994-01-01' + interval '1' year;