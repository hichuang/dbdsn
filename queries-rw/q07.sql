-- QUERY 7
select
	mv_supp_nation as supp_nation,
	mv_cust_nation as cust_nation,
	mv_l_year as l_year,
	sum(mv_volume) as revenue
from
	mv_q07
where
	((mv_supp_nation = 'FRANCE' and mv_cust_nation = 'GERMANY')
		or (mv_supp_nation = 'GERMANY' and mv_cust_nation = 'FRANCE'))
	and mv_shipdate between date '1995-01-01' and date '1996-12-31'
group by
	mv_supp_nation,
	mv_cust_nation,
	mv_l_year
order by
	supp_nation,
	cust_nation,
	l_year;