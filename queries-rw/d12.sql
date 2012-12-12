-- QUERY 12
drop table if exists mv_q12;
create table mv_q12
	select
		l_shipmode as mv_shipmode,
		o_orderpriority as mv_orderprior,
		l_receiptdate as mv_recdate,
		count(*) as mv_linecount
	from
		orders,
		lineitem
	where
		o_orderkey = l_orderkey
		and l_commitdate < l_receiptdate
		and l_shipdate < l_commitdate
	group by
		l_shipmode,
		o_orderpriority,
		l_receiptdate
	order by
		mv_shipmode,
		mv_orderprior,
		mv_recdate;

alter table mv_q12 add primary key (mv_shipmode, mv_orderprior, mv_recdate, mv_linecount);