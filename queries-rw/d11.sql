-- QUERY 11
drop table if exists mv_q11;
create table mv_q11
	select 
		ps_partkey as mv_partkey,
		sum(ps_supplycost * ps_availqty) as mv_value,
		n_name as mv_nname
	from
		partsupp,
		supplier,
		nation
	where
		ps_suppkey = s_suppkey
		and s_nationkey = n_nationkey
	group by
		ps_partkey,
		n_name
	order by
		mv_nname;

alter table mv_q11 add primary key (mv_nname, mv_partkey);