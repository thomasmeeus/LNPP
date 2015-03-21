@test "Test if Nginx-apt-repository is set" {
  test -e /etc/apt/sources.list.d/nginx.list
}
@test "Test if the Nginx package is installed" {
  run bash -c "dpkg --get-selections | grep nginx"
  [ $status -eq 0 ]
}

@test "Test if server_tokens is set to off" {
  egrep -q  "server_tokens off" /etc/nginx/nginx.conf
}

@test "Test if nginx sendfile is on" {
  egrep -q  "sendfile on" /etc/nginx/nginx.conf
}

@test "Test if nginx tcp_nopush is on" {
  egrep -q  "tcp_nopush on" /etc/nginx/nginx.conf
}

@test "Test if nginx tcp_nodelay is on" {
  egrep -q  "tcp_nodelay on" /etc/nginx/nginx.conf
}

@test "Test if nginx keepalive_timeout is 20" {
  egrep -q  "keepalive_timeout\s+20" /etc/nginx/nginx.conf
}

@test "Test if nginx client_header_timeout is 20" {
  egrep -q  "client_header_timeout\s+20" /etc/nginx/conf.d/00-tuning.conf
}

@test "Test if nginx client_body_timeout is 20" {
  egrep -q  "client_body_timeout\s+20" /etc/nginx/conf.d/00-tuning.conf
}

@test "Test if nginx reset_timedout_connection is on" {
  egrep -q  "reset_timedout_connection\s+on" /etc/nginx/conf.d/00-tuning.conf
}

@test "Test if nginx send_timeout is 20" {
  egrep -q  "send_timeout\s+20" /etc/nginx/conf.d/00-tuning.conf
}

@test "Test if nginx gzip is on" {
  egrep -q  "gzip\s+on" /etc/nginx/nginx.conf
}

@test "Test if nginx gzip compression is set to 5" {
  egrep -q  "gzip_comp_level\s+5" /etc/nginx/nginx.conf
}

@test "Test if nginx server_names_hash_bucket_size is 128" {
  egrep -q  "server_names_hash_bucket_size\s+128" /etc/nginx/nginx.conf
}

@test "Test if nginx types_hash_max_size is 1024" {
  egrep -q  "types_hash_max_size\s+1024" /etc/nginx/nginx.conf
}

@test "Test if nginx types_hash_bucket_size is 64" {
  egrep -q  "types_hash_bucket_size\s+64" /etc/nginx/nginx.conf
}

@test "Test if nginx map_hash_bucket_size is 128" {
  egrep -q  "map_hash_bucket_size\s+128" /etc/nginx/conf.d/00-tuning.conf
}

@test "Test if nginx status-site is enabled" {
  test -e "/etc/nginx/conf.d/02-status.conf"
}

@test "Test if nginx default-project is enabled" {
  test -e "/etc/nginx/sites-enabled/project1.conf"
}

@test "Test if nginx status-site listens only on localhost" {
  grep "listen 127.0.0.1" /etc/nginx/conf.d/02-status.conf
}

@test "Test if only secure protocols are allowed" {
  grep -q "TLSv1 TLSv1.1 TLSv1.2" /etc/nginx/conf.d/01-ssl.conf
}

@test "Test if only ssl_prefer_server_ciphers are enabled" {
  egrep -q "ssl_prefer_server_ciphers\s+on" /etc/nginx/conf.d/01-ssl.conf
}

@test "Test if only secure ssl_ciphers protocols  allowed" {
  grep -q "AES256+EECDH" /etc/nginx/conf.d/01-ssl.conf
}