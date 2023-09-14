# AirBnB clone web server setup and configuration

exec { 'update':
  provider => 'shell',
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec { 'install Nginx':
  provider => 'shell',
  command  => 'sudo apt-get -y install nginx',
  before   => Exec['create directories'],
}

exec { 'create directories':
  provider => 'shell',
  command  => 'sudo mkdir -p /data/web_static/releases/test /data/web_static/shared',
  before   => file['create test html file'],
}

file { 'create test html file':
  ensure  => present,
  path    => '/data/web_static/releases/test/index.html',
  content => '<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>',
  before  => file['write into nginx config file'],
}

exec { 'remove current directory, if exists':
  provider => 'shell',
  command  => '[ -d /data/web_static/current ] && sudo rm -rf /data/web_static/current',
  before   => Exec['link test directory to current directory'],
}

exec { 'link test directory to current directory':
  provider => 'shell',
  command  => 'sudo ln -sf /data/web_static/releases/test/ /data/web_static/current',
  before   => file['give user and group ownership'],
}

file { 'give user and group ownership':
  ensure  => directory,
  path    => '/data',
  recurse => true,
  user    => 'ubuntu',
  group   => 'ubuntu',
  before  => file['write into nginx config file'],
}

file { 'create index.html':
  ensure  => present,
  path    => '/var/www/html/index.html',
  content => 'Hello, World!',
  before  => file['write into nginx config file'],
}

exec { 'create error directory':
  provider => 'shell',
  command  => 'sudo mkdir -p /var/www/error/',
  before   => file['create 404.html'],
}

file { 'create 404.html':
  ensure  => present,
  path    => '/var/www/error/404.html',
  content => "Ceci n'est pas une page",
  before  => file['write into nginx config file'],
}

file { 'write into nginx config file':
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
  before  => Exec['restart Nginx'],
}

exec { 'restart Nginx':
  provider => 'shell',
  command  => 'sudo service nginx restart',
}
