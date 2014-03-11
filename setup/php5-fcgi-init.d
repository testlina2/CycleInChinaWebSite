#! /bin/bash

PHP_SCRIPT=/usr/bin/php5-fcgi
RETVAL=0
case "$1" in
	start)
		echo "Start fastcgi ing..."
		$PHP_SCRIPT
		RETVAL=$?
		;;
	stop)
		echo "Stop fastcgi ing..."
		killall -9 php5-cgi
		RETVAL=$?
		;;
	restart)
		echo "Restart fastcgi ing..."
		killall -9 php5-cgi
		$PHP_SCRIPT
		RETVAL=$?
		;;
	*)
		echo "Usage: php-fastcgi {start|stop|restart}"
		exit 1
	;;
esac
exit $RETVAL