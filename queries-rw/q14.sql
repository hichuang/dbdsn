-- QUERY 14
select
	100.00 * sum(case when mv_type like 'PROMO%'
					then mv_revenue else 0 
			  	end) / sum(mv_revenue) as promo_revenue 
from
	mv_q14
where
	mv_shipdate >= date '1995-09-01'
	and mv_shipdate < date '1995-09-01' + interval '1' month;