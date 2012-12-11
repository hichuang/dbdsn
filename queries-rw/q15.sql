-- QUERY 15
select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier,
	(select 
		mv_suppkey,
		sum(mv_revenue) as total_revenue
	 from
	 	mv_q15
	 where
	 	mv_shipdate >= date '1996-01-01'
		and l_shipdate < date '1996-01-01' + interval '3' month
	 group by
	 	mv_suppkey
	 order by
	 	total_revenue asc
	 limit 1) as revenue0
where
	s_suppkey = mv_suppkey
order by
	s_suppkey;