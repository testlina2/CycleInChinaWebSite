#!/bin/bash

if [ "x$USER" != "xroot" ]; then
	exec sudo ./$0 "$@"
fi
echo -----------------------------------------
echo starting to config under root env
echo -----------------------------------------
function die()
{
	echo "Error: $@" > /dev/stderr
	exit 1
}

x_root="$PWD"
if [ "$x_root" == "/var/www" ] ; then
	x_user="www-data"
	x_group="www-data"
else
	x_user="$SUDO_USER"
	x_group="$SUDO_USER"
fi

echo current user is : $x_user
[ "${x_root}" == "$(pwd)" ] || die "website must be install to ${x_root}"
echo -----------------------------------------

which nginx || die "Read the /setup/installnginx.README file to install nginx"
which php5-cgi || die "Run the /setup/installphp.sh to install php5-cgi"
which spawn-fcgi || die "sudo apt-get install spawn-fcgi"
echo -----------------------------------------

cp ./setup/php5-fcgi-bin /usr/bin/php5-cgi
cp ./setup/php5-fcgi-init.d /etc/init.d/php5-cgi
cp ./config/default.nginx /etc/nginx/sites-available/default
cp ./config/nginx.conf /etc/nginx/nginx.conf

echo config and script files are setted 
echo ----------------------------------------
echo "now changing the use's owner"

chown -R ${x_user}:${x_group} "${x_root}"

/etc/init.d/nginx restart
/etc/init.d/php5-cgi restart

echo --------------------------------------- this is the end enjoy it
