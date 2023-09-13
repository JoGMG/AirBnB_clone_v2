# AirBnB clone web server setup and configuration

exec { 'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec { 'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
  before   => Exec['create directories'],
}

exec { 'create directories':
  provider => shell,
  command  => 'mkdir -p /data/web_static/releases/test /data/web_static/shared',
  before   => Exec['create test html file'],
}

exec { 'create test html file':
  provider => shell,
  command  => 'printf %s "<html>
	<head>
	</head>
	<body>
		Holberton School
	</body>
</html>" > /data/web_static/releases/test/index.html',
  before   => Exec['remove current directory, if exists'],
}

exec { 'remove current directory, if exists':
  provider => shell,
  command  => '[ -d /data/web_static/current ] && rm -rf /data/web_static/current',
  before   => Exec['link test directory to current directory'],
}

exec { 'link test directory to current directory':
  provider => shell,
  command  => 'ln -sf /data/web_static/releases/test/ /data/web_static/current',
  before   => file['give user and group ownership'],
}

file { 'give user and group ownership':
  ensure  => directory,
  path    => '/data',
  recurse => true,
  user    => 'ubuntu',
  group   => 'ubuntu',
  before  => Exec['write into nginx config file'],
}

file { 'create index.html':
  ensure  => present,
  path    => '/var/www/html/index.html',
  content => 'Hello, World!',
  before  => Exec['write into nginx config file'],
}

exec { 'create error directory':
  provider => shell,
  command  => 'mkdir -p /var/www/error/',
  before   => file['create 404.html'],
}

file { 'create 404.html':
  ensure  => present,
  path    => '/var/www/error/404.html',
  content => "Ceci n'est pas une page",
  before  => Exec['write into nginx config file'],
}

exec { 'write into nginx config file':
  provider => shell,
  command  => 'printf %s "server {
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
}" > /etc/nginx/sites-available/default',
  before   => Exec['restart Nginx'],
}

exec { 'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
