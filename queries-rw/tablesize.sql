select table_schema "DB name", sum(data_length + index_length)/1024/1024 "Total Size in MB"
from information_schema.TABLES
where table_schema = "tpch"
group by table_schema;
