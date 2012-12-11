-- QUERY 16
select
	mv_brand as p_brand,
	mv_type as p_type,
	mv_size as p_size,
	count(distinct mv_suppkey) as supplier_cnt
from
	mv_q16
where
	mv_brand <> 'Brand#45'
	and mv_type not like 'MEDIUM POLISHED%'
	and mv_size in (49, 14, 23, 45, 19, 3, 36, 9)
	and mv_comment not like '%Customer%Complaints%'
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size;