-- QUERY 8
drop table if exists mv_q08;
create table mv_q08 ( mv_o_year INTEGER NOT NULL,
					  mv_nation CHAR(25) NOT NULL,
					  mv_rname CHAR(25) NOT NULL,
					  mv_orderdate DATE NOT NULL,
					  mv_type VARCHAR(25) NOT NULL,
					  mv_volumn DECIMAL(15,4) NOT NULL ); 

insert into mv_q08 (mv_o_year, mv_nation, mv_rname, mv_orderdate, mv_type, mv_volumn)
	select 
		extract(year from o_orderdate) as o_year,
		n2.n_name as nation,
		r_name,
		o_orderdate,
		p_type,
		sum(l_extendedprice * (1 - l_discount))
	from 
		part,
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2,
		region
	where
		p_partkey = l_partkey
		and s_suppkey = l_suppkey
		and l_orderkey = o_orderkey
		and o_custkey = c_custkey
		and c_nationkey = n1.n_nationkey
		and n1.n_regionkey = r_regionkey
		and s_nationkey = n2.n_nationkey
	group by
		o_year,
		nation,
		r_name,
		o_orderdate,
		p_type;