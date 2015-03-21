# encoding: UTF-8
package 'libxml-perl'

include_recipe 'munin::client'
include_recipe 'munin::server'

%w(
  nfs4_client
  nfs_client
  nfsd
  nfsd4
  exim_mailqueue
  exim_mailstats
).each do |plugin_name|
  munin_plugin plugin_name do
    enable false
  end
end

git '/usr/share/munin/plugins/contrib' do
  repository 'https://github.com/munin-monitoring/contrib.git'
  action :sync
end

munin_plugin 'contrib/plugins/network/ping/ping' do
  plugin 'ping'
end

munin_plugin 'contrib/plugins/logins/logins' do
  plugin 'logins'
end

munin_plugin 'contrib/plugins/network/traffic' do
  plugin 'traffic'
end

munin_plugin 'contrib/plugins/mail/postfix_mail_stats' do
  plugin 'postfix_mail_stats'
end

munin_plugin 'contrib/plugins/php/php5-fpm_status' do
  plugin 'php5-fpm_status'
end

munin_plugin 'contrib/plugins/php/php_opcache' do
  plugin 'php_opcache'
end

munin_plugin 'nginx_status'
munin_plugin 'nginx_request'

template 'munin_nginx' do
  path '/etc/munin/plugin-conf.d/nginx'
  action :create
end
