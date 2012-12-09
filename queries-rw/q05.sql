-- QUERY 5
select
	mv_nname as n_name,
	sum(mv_revenue) as revenue
from
	mv_q05
where
	and mv_rname = 'ASIA'
	and mv_orderdate >= date '1994-01-01'
	and mv_orderdate < date '1994-01-01' + interval '1' year
group by
	mv_nname
order by
	revenue desc;
