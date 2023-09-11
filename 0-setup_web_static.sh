#!/usr/bin/env bash
# Sets up my web servers for the deployment of `web_static`.

sudo -i
apt-get -y update
apt-get -y install nginx

mkdir -p /data/web_static/releases/test /data/web_static/shared
printf %s "<html>
	<head>
	</head>
	<body>
		Holberton School
	</body>
</html>" > /data/web_static/releases/test/index.html

[ -d /data/web_static/current ] && rm -rf /data/web_static/current
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -hR ubuntu:ubuntu /data

echo 'Hello World!' > /var/www/html/index.html
mkdir -p /var/www/error/
echo "Ceci n'est pas une page" > /var/www/error/404.html
var=$(hostname)
printf %s "server {
    listen 80;
    listen [::]:80 default_server;

    add_header X-Served-By ""$var"";

	root /var/www/html/;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

	location /hbnb_static/ {
        alias /data/web_static/current/;
	}

    error_page 404 /404.html;
    location = /404.html {
        root /var/www/error/;
        internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
