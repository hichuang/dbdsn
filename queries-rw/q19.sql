-- QUERY 19
select
	sum(mv_revnue) as revenue
from
	mv_q19
where
	(
		mv_brand = 'Brand#12'
		and mv_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and mv_qty >= 1 and mv_qty <= 1 + 10
		and mv_size between 1 and 5
		and mv_shipmode in ('AIR', 'AIR REG')
		and mv_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		mv_brand = 'Brand#23'
		and mv_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and mv_qty >= 10 and mv_qty <= 10 + 10
		and mv_size between 1 and 10
		and mv_shipmode in ('AIR', 'AIR REG')
		and mv_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		mv_brand = 'Brand#34'
		and mv_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and mv_qty >= 20 and mv_qty <= 20 + 10
		and mv_size between 1 and 15
		and mv_shipmode in ('AIR', 'AIR REG')
		and mv_shipinstruct = 'DELIVER IN PERSON'
	);