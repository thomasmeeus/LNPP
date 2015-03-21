# encoding: UTF-8


default['sysadmin_email'] = 'thomas@sector7g.be'

default['openssh']['server']['port'] = %w(22 22345)
default['openssh']['server']['permit_root_login'] = 'no'
default['openssh']['server']['client_alive_interval'] = '30'
default['openssh']['server']['use_dns'] = 'no'

default['openssh']['client'] = { forward_agent: 'yes' }

default['nginx']['default_site_enabled'] = false
default['nginx']['status']['port'] = 8080
default['nginx']['worker_connections'] = 4096
default['nginx']['event'] = 'epoll'
default['nginx']['multi_accept'] = true
default['nginx']['keepalive_timeout'] = 20
default['nginx']['client_header_timeout'] = 20
default['nginx']['client_body_timeout'] = 20
default['nginx']['client_max_body_size'] = '100M'
default['nginx']['reset_timedout_connection'] = 'on'
default['nginx']['send_timeout'] = 20
default['nginx']['gzip_vary'] = 'on'
default['nginx']['gzip_comp_level'] = 5
default['nginx']['gzip_min_length'] = 256
default['nginx']['gzip_types'] = %w(
  image/svg+xml
  text/plain
  text/css
  application/x-javascript
  text/xml
  application/xml
  application/rss+xml
  application/atom+xml
  text/javascript
  application/javascript
  application/json
  text/mathml
)
default['nginx']['server_names_hash_bucket_size'] = 128
default['nginx']['map_hash_bucket_size'] = 128
default['nginx']['types_hash_max_size'] = 1024
default['nginx']['server_tokens'] = 'off'

default['nginx']['open_file_cache'] = true
default['nginx']['open_file_cache_max'] = 8192
default['nginx']['open_file_cache_inactive'] = '1d'
default['nginx']['open_file_cache_valid'] = '1d'
default['nginx']['open_file_cache_min_uses'] = 2
default['nginx']['open_file_cache_errors'] = 'on'

default['php']['version'] = '5.6'

case node['php']['version']
when '5.6'
  default['php']['dotdeb_distribution'] = 'wheezy-php56'
when '5.5'
  default['php']['dotdeb_distribution'] = 'wheezy-php55'
end

default['percona']['use_percona_repos'] = true

default['percona']['server']['debian_password'] = 'ThS5ad0y28Ban7MqRkh4'
default['percona']['server']['root_password'] = 'ThS5ad0y28Ban7MqRkh4'
default['percona']['backup']['password'] = 'ThS5ad0y28Ban7MqRkh4'
default['percona']['conf']['mysqld']['bind-address'] = '127.0.0.1'
default['percona']['conf']['mysqld']['max_allowed_packet'] = '16M'
default['percona']['conf']['mysqld']['query_cache_type'] = '1'
default['percona']['conf']['mysqld']['query_cache_size'] = '256M'
default['percona']['conf']['mysqld']['query_cache_limit'] = '2M'
default['percona']['conf']['mysqld']['query_cache_strip_comments'] = '1'
default['percona']['conf']['mysqld']['innodb_file_per_table'] = '1'
default['percona']['conf']['mysqld']['innodb_buffer_pool_size'] = '256M'
default['percona']['conf']['mysqld']['innodb_thread_concurrency'] = '8'
default['percona']['conf']['mysqld']['innodb_flush_log_at_trx_commit'] = '1'
default['percona']['conf']['mysqld']['key_buffer'] = '16M'
default['percona']['conf']['mysqld']['thread_stack'] = '256K'
default['percona']['conf']['mysqld']['join_buffer_size'] = '512K'
default['percona']['conf']['mysqld']['thread_cache_size'] = '8'
default['percona']['conf']['mysqld']['table_open_cache'] = '2048'
default['percona']['conf']['mysqld']['expire_logs_days'] = '7'
default['percona']['conf']['mysqld']['max_binlog_size'] = '1024MB'
default['percona']['conf']['mysqld']['interactive_timeout'] = '120'
default['percona']['conf']['mysqld']['wait_timeout'] = '120'
default['percona']['conf']['mysqld']['max_connections'] = '100'
default['percona']['conf']['mysqld']['max_user_connections'] = '0'

# ONLY FOR TESTING

default['munin']['web_server'] = 'nginx'
default['munin']['server_auth_method'] = 'htpasswd'
default['munin']['web_server_port'] = 8080

## User accounts
default['users'] = %w(thomas)
default['user']['ssh_keygen'] = false

## projects
default['projects'] = %w(project1) ## max 8 chars