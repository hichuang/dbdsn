-- QUERY 21
select
	mv_sname as s_name,
	sum(mv_numwait) as numwait
from
	mv_q21
where
	mv_orderstat = 'F'
	and mv_nname = 'SAUDI ARABIA'
group by
	mv_sname
order by
	numwait desc,
	s_name;