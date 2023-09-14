# AirBnB clone web server setup and configuration

package { 'nginx':
  ensure => 'installed',
}

file { '/data':
  ensure => directory,
}

file { '/data/web_static':
  ensure => directory,
}

file { '/data/web_static/releases':
  ensure => directory,
}

file { '/data/web_static/releases/test':
  ensure => directory,
}

file { '/data/web_static/shared':
  ensure => directory,
}

file { '/data/web_static/releases/test/index.html':
  ensure  => present,
  content => '<html>
	<head>
	</head>
	<body>
		Holberton School
	</body>
</html>',
}

file { '/data/web_static/current':
  ensure  => absent,
  recurse => true,
}

file { '/data/web_static/current':
  ensure => 'symlink',
  target => '/data/web_static/releases/test/',
  force  => true,
}

file { '/data/':
  ensure  => directory,
  user    => 'ubuntu',
  group   => 'ubuntu',
  recurse => true,
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello, World!',
}

file { '/var/www/error/':
  ensure  => directory,
  recurse => true,
}

file { '/var/www/error/404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "server {
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
}",
}

exec { 'nginx restart':
  path => '/etc/init.d/',
}
