-- QUERY 8
select
	mv_o_year as o_year,
	sum(case
		when mv_nation = 'BRAZIL' then mv_volume
		else 0
	end) / sum(mv_volume) as mkt_share
from 
	mv_q08
where
	mv_rname = 'AMERICA'
	and mv_orderdate between date '1995-01-01' and date '1996-12-31'
	and mv_type = 'ECONOMY ANODIZED STEEL'
group by
	mv_o_year
order by
	mv_o_year;