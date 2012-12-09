-- QUERY 4
drop table if exists mv_q04;
create table mv_q04
	select
		o_orderpriority as mv_orderpriority,
		o_orderdate as mv_orderdate,
		count(*) as mv_order_count
	from
		orders
	where
		exists (
			select
				*
			from
				lineitem
			where
				l_orderkey = o_orderkey
				and l_commitdate < l_receiptdate
		)
	group by
		o_orderpriority,
		o_orderdate
	order by
		o_orderpriority,
		o_orderdate;