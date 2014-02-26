#!/bin/bash

apt-get install -y --force-yes \
  build-essential \
  lsb-release \
  vim \
  nginx \
  libcurl4-openssl-dev \
  libpcre3-dev \
  php5-common \
  php-pear \
  php5-fpm \
  php5-dev \
  php5-curl \
  php5-cli \

pear config-set php_ini /etc/php5/fpm/php.ini
printf "\n" | pecl install pecl_http-1.7.6
cp -Rfv /usr/share/nginx/html/* /vagrant/php_scripts

  cat << 'EOF' > /etc/nginx/nginx.conf
user www-data;
worker_processes 4;
pid /run/nginx.pid;

events {
	worker_connections 768;
}

http {

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	gzip on;
	gzip_disable "msie6";

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

	server {
		listen 8000;

		root /vagrant/php_scripts;
		index index.php index.html index.htm;

		server_name example.com;

		location / {
			try_files $uri $uri/ /index.html;
		}

		error_page 404 /404.html;
		error_page 500 502 503 504 /50x.html;
		location = /50x.html {
			root /usr/share/nginx/www;
		}

		# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
		location ~ \.php$ {
			try_files $uri =404;
			fastcgi_pass unix:/var/run/php5-fpm.sock;
			fastcgi_index index.php;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
			include fastcgi_params;
		}
	}
}
EOF

service nginx start
