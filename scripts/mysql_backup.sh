#!/bin/bash
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASS="${MYSQL_PASS:-}"
BACKUP_DIR="${BACKUP_DIR:-/backup/mysql}"
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR/$DATE"

DBS=$(mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" -e "SHOW DATABASES;" | grep -Ev "Database|information_schema|performance_schema|sys")

for DB in $DBS; do
    echo "Backing up $DB..."
    mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASS" --single-transaction --routines --triggers "$DB"         | gzip > "$BACKUP_DIR/$DATE/${DB}.sql.gz"
done

find "$BACKUP_DIR" -maxdepth 1 -type d -mtime +7 -exec rm -rf {} +
echo "MySQL backup complete: $BACKUP_DIR/$DATE"
