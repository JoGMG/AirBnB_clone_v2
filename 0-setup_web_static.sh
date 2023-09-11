#!/usr/bin/env bash
# Sets up my web servers for the deployment of `web_static`.

sudo -i
if [[ "$(which nginx | grep -c nginx)" == '0' ]]; then
    apt-get -y update
    apt-get -y install nginx
fi

mkdir -p /data/web_static/releases/test /data/web_static/shared
printf %s "<html>
	<head>
	</head>
	<body>
		Holberton School
	</body>
</html>" > /data/web_static/releases/test/index.html

[ -d /data/web_static/current ] && rm /data/web_static/current
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -hR ubuntu:ubuntu /data

echo 'Hello World!' > /var/www/html/index.html
echo "Ceci n'est pas une page" > /var/www/html/404.html
var=$(hostname)
printf %s "server {
    listen 80;
    listen [::]:80 default_server;

    add_header X-Served-By "$var";

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
		root /var/www/html;
        try_files \$uri \$uri/ =404;
    }

	location /hbnb_static/ {
        alias /data/web_static/current/;
        try_files \$uri \$uri/ =404;
	}

    error_page 404 /404.html;
    location = /404.html {
        root /var/www/html;
        internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
