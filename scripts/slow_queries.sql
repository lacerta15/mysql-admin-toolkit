-- Enable and review slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-query.log';

-- Check current slow query stats
SELECT
  schema_name,
  digest_text,
  count_star,
  avg_timer_wait/1000000000 AS avg_ms,
  sum_rows_examined
FROM performance_schema.events_statements_summary_by_digest
ORDER BY avg_timer_wait DESC
LIMIT 20;
