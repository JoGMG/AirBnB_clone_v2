# Puppet for setup

$nginx_conf = "server {
    listen 80;
    listen [::]:80 default_server;

    add_header X-Served-By \$hostname;

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
}"

package { 'nginx':
  ensure   => 'present',
  provider => 'apt',
}

-> file { '/data/web_static/releases/test':
  ensure  => 'directory',
  recurse => true,
}

-> file { '/data/web_static/shared':
  ensure => 'directory',
}

-> file { '/data/web_static/releases/test/index.html':
  ensure  => 'present',
  content => "this webpage is found in data/web_static/releases/test/index.htm \n",
}

-> file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
}

-> exec { 'chown -R ubuntu:ubuntu /data/':
  path => '/usr/bin/:/usr/local/bin/:/bin/',
}

file { '/var/www/html':
  ensure  => 'directory',
  recurse => true,
}

file { '/var/www/error':
  ensure  => 'directory',
  recurse => true,
}

-> file { '/var/www/html/index.html':
  ensure  => 'present',
  content => "This is my first upload  in /var/www/index.html***\n",
}

-> file { '/var/www/error/404.html':
  ensure  => 'present',
  content => "Ceci n'est pas une page - Error page\n",
}

-> file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => $nginx_conf,
}

-> exec { 'nginx restart':
  path => '/etc/init.d/',
}
