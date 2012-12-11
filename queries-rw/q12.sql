-- QUERY 12
select
	mv_shipmode as l_shipmode,
	case when mv_orderprior in ('1-URGENT', '2-HIGH') 
		then sum(mv_linecount) end 'high_line_count',
	case when mv_orderprior not in ('1-URGENT', '2-HIGH') 
		then sum(mv_linecount) end 'low_line_count'
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