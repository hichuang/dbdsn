-- QUERY 11
select
	mv_partkey as ps_partkey,
	sum(mv_value) as value
from
	mv_q11
where
	mv_nname = 'GERMANY'
group by
	mv_partkey having
		sum(mv_value) > (
			select sum(mv_value) * 0001000000
			from mv_q11
			where mv_nname = 'GERMANY'
		)
order by
	value desc;