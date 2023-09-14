# AirBnB clone web server setup and configuration

package { 'nginx':
  ensure => 'installed',
}

file { 'create ../test':
  ensure => directory,
  path   => '/data/web_static/releases/test',
  before => file['create ../index.html'],
}

file { 'create ../shared':
  ensure => directory,
  path   => '/data/web_static/shared',
}

file { 'create ../index.html':
  ensure  => present,
  path    => '/data/web_static/releases/test/index.html',
  content => '<html>
	<head>
	</head>
	<body>
		Holberton School
	</body>
</html>',
  before  => file['link ../test to ../current'],
}

file { 'remove ../current, if exists':
  ensure  => absent,
  path    => '/data/web_static/current',
  recurse => true,
  before  => file['link ../test to ../current'],
}

file { 'link ../test to ../current':
  ensure => 'symlink',
  path   => '/data/web_static/releases/test/',
  target => '/data/web_static/current',
  force  => true,
  before => file['give ownership'],
}

file { 'give ownership':
  ensure  => directory,
  path    => '/data/',
  user    => 'ubuntu',
  group   => 'ubuntu',
  recurse => true,
  before  => file['nginx config file'],
}

file { 'create index.html':
  ensure  => present,
  path    => '/var/www/html/index.html',
  content => 'Hello, World!',
  before  => file['nginx config file'],
}

file { 'create ../error':
  ensure => directory,
  path   => '/var/www/error/',
  before => file['create 404.html'],
}

file { 'create 404.html':
  ensure  => present,
  path    => '/var/www/error/404.html',
  content => "Ceci n'est pas une page",
  before  => file['nginx config file'],
}

file { 'nginx config file':
  ensure  => present,
  path    => '/etc/nginx/sites-available/default',
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
  before  => Exec['restart_nginx'],
}

exec { 'restart_nginx':
  command     => '/etc/init.d/nginx restart',
  refreshonly => true,
}
