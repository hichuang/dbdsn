-- QUERY 16
drop table if exists mv_q16;
create table mv_q16
	select
		p_brand as mv_brand,
		p_type as mv_type,
		p_size as mv_size,
		s_comment as mv_comment,
		ps_suppkey as mv_suppkey
	from
		partsupp,
		part,
		supplier
	where
		p_partkey = ps_partkey
		and ps_suppkey = s_suppkey
	group by
		p_brand,
		p_type,
		p_size,
		s_comment,
		ps_suppkey