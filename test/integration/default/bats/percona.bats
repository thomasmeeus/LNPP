#!/usr/bin/env bats

@test "Test if Percona-server is installed" {
  dpkg --get-selections | grep percona-server-server
}

@test "Test if Percona-client is installed" {
  dpkg --get-selections | grep percona-server-client
}

@test "Test if Percona max-allow-packet is 16M" {
  grep "max_allowed_packet = 16M" /etc/my.cnf
}

@test "Test if Percona query_cache_size is 256M" {
  grep "query_cache_size = 256M" /etc/my.cnf
}

@test "Test if Percona is only listing at localhost" {
  grep "bind-address = 127.0.0.1" /etc/my.cnf
}

@test "Test if Percona query_cache_type is enabled" {
  grep "query_cache_type = 1" /etc/my.cnf
}

@test "Test if Percona query_cache_limit is set to 2M" {
  grep "query_cache_limit = 2M" /etc/my.cnf
}

@test "Test if Percona query_cache_strip_comments is enabled" {
  grep "query_cache_strip_comments = 1" /etc/my.cnf
}

@test "Test if Percona innodb_file_per_table is set to 1" {
  grep "innodb_file_per_table = 1" /etc/my.cnf
}

@test "Test if Percona innodb_buffer_pool_size is set to 256M" {
  grep "innodb_buffer_pool_size = 256M" /etc/my.cnf
}

@test "Test if Percona innodb_thread_concurrency is set to 8" {
  grep "innodb_thread_concurrency = 8" /etc/my.cnf
}

@test "Test if Percona innodb_flush_log_at_trx_commit is enabled" {
  grep "innodb_flush_log_at_trx_commit = 1" /etc/my.cnf
}

@test "Test if Percona key_buffer is set to 16M" {
  grep "key_buffer = 16" /etc/my.cnf
}

@test "Test if Percona thread_stack is set to 256K" {
  grep "thread_stack = 256K" /etc/my.cnf
}

@test "Test if Percona thread_cache_size is set to 8" {
  grep "thread_cache_size = 8" /etc/my.cnf
}

@test "Test if Percona expire_logs_days is set to 7" {
  grep "expire_logs_days = 7" /etc/my.cnf
}

@test "Test if Percona max_binlog_size is set to 1024M" {
  grep "max_binlog_size = 1024M" /etc/my.cnf
}

@test "Test if Percona interactive_timeout is set to 120" {
  grep "interactive_timeout = 120" /etc/my.cnf
}

@test "Test if Percona wait_timeout is set to 120" {
  grep "wait_timeout = 120" /etc/my.cnf
}

@test "Test if Percona max_connections is set to 100" {
  grep "max_connections = 100" /etc/my.cnf
}

@test "Test if Percona max_user_connections is set to 0" {
  grep "max_user_connections = 0" /etc/my.cnf
}