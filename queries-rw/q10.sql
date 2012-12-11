-- QUERY 10
select
	mv_custkey as c_custkey,
	mv_cname as c_name,
	sum(mv_revenue) as revenue,
	mv_acctbal as c_acctbal,
	mv_nname as n_name,
	mv_addr as c_address,
	mv_phone as c_phone,
	mv_comment as c_comment
from
	mv_q10
where
	mv_orderdate >= date '1993-10-01'
	and mv_orderdate < date '1993-10-01' + interval '3' month
	and mv_returnflag = 'R'
group by
	mv_custkey,
	mv_name,
	mv_acctbal,
	mv_phone,
	mv_nname,
	mv_addr,
	mv_comment
order by
	revenue desc;