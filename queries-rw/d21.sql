-- QUERY 21
drop table if exists mv_q21;
create table mv_q21
	select
		s_name as mv_sname,
		count(*) as mv_numwait,
		o_orderstatus as mv_orderstat,
		n_name as mv_nname
	from
		supplier,
		lineitem l1,
		orders,
		nation
	where
		s_suppkey = l1.l_suppkey
		and o_orderkey = l1.l_orderkey
		and l1.l_receiptdate > l1.l_commitdate
		and exists (
			select
				*
			from
				lineitem l2
			where
				l2.l_orderkey = l1.l_orderkey
				and l2.l_suppkey <> l1.l_suppkey
		)
		and not exists (
			select
				*
			from
				lineitem l3
			where
				l3.l_orderkey = l1.l_orderkey
				and l3.l_suppkey <> l1.l_suppkey
				and l3.l_receiptdate > l3.l_commitdate
		)
		and s_nationkey = n_nationkey
	group by
		o_orderstatus,
		n_name,
		s_name;
