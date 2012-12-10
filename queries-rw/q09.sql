-- QUERY 9
select
	mv_nation as nation,
	mv_o_year as o_year,
	sum(mv_amount) as sum_profit
from
	mv_q09
where
	mv_pname like '%green%'
group by
	mv_nation,
	mv_o_year
order by
	nation,
	o_year desc;