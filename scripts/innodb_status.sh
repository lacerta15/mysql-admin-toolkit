#!/bin/bash
# Quick InnoDB health check
mysql -u"${MYSQL_USER:-root}" -p"${MYSQL_PASS:-}" -e "
  SHOW ENGINE INNODB STATUS\G
  SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool%';
  SHOW GLOBAL STATUS LIKE 'Threads%';
  SHOW PROCESSLIST;
"
