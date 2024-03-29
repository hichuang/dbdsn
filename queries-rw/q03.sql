-- QUERY 3
select
	mv_orderkey as l_orderkey,
	sum(mv_revenue) as revenue,
	mv_orderdate as o_orderdate,
	mv_shippriority as o_shippriority
from
	mv_q03
where
	mv_mktsegment = 'BUILDING'
	and mv_orderdate < date '1995-03-15'
	and mv_shipdate > date '1995-03-15'
group by
	mv_orderkey,
	mv_orderdate,
	mv_shippriority
order by
	revenue desc,
	mv_orderdate;
