#!/bin/sh

INTERVAL=5
PREFIX=$INTERVAL-sec-status
RUNFILE=/home/grande/mysql-study/high-performance-mysql/benchmarks/running
mysql -uroot -proot -e 'SHOW GLOBAL VARIABLES' >> mysql-variables
while test -e $RUNFILE; do
	file=$(date +%F_%I)
	sleep=$(date +%s.%N | awk "{print $INTERVAL - (\$1 % $INTERVAL)}")
	sleep $sleep
	ts="$(date +"TS $s.%N %F %T")"
	loagavg="$(uptime)"
	echo "$ts $loadavg" >> $PREFIX-${file}-status
	mysql -uroot -proot -e 'SHOW GLOBAL STATUS' >> $PREFIX-${file}-status &
        echo "$ts $loadavg" >> $PREFIX-${file}-innodbstatus
        mysql -uroot -proot -e 'SHOW ENGINE INNODB STATUS\G' >> $PREFIX-${file}-innodbstatus &
        echo "$ts $loadavg" >> $PREFIX-${file}-processlist
        mysql -uroot -proot -e 'SHOW FULL PROCESSLIST\G' >> $PREFIX-${file}-processlist &
	echo $ts
done
echo Exitin because $RUNFILE does not exist.
