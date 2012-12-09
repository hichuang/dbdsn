-- QUERY 3
select
	l_orderkey,
	sum(mv_revenue) as revenue,
	o_orderdate,
	o_shippriority
from
	mv_q03
where
	c_mktsegment = 'BUILDING'
	and o_orderdate < date '1995-03-15'
	and l_shipdate > date '1995-03-15'
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate;
