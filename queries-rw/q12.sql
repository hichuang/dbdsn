-- QUERY 12
select
	mv_shipmode as l_shipmode,
	sum(case when mv_orderprior in ('1-URGENT', '2-HIGH') 
		then mv_linecount else 0 end) as high_line_count,
	sum(case when mv_orderprior not in ('1-URGENT', '2-HIGH') 
		then mv_linecount else 0 end) as low_line_count
from
	mv_q12
where
	mv_shipmode in ('MAIL', 'SHIP')
	and mv_recdate >= date '1994-01-01'
	and mv_recdate < date '1994-01-01' + interval '1' year
group by
	mv_shipmode
order by
	l_shipmode;