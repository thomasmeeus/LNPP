# encoding: UTF-8

include_recipe 'php::default'
include_recipe 'php::fpm'
include_recipe 'php::module_mysql'
include_recipe 'php::module_intl'

link "#{node['php']['fpm_conf_dir']}/conf.d/20-mysql.ini" do
  action :delete
end
link "#{node['php']['fpm_conf_dir']}/conf.d/20-odbc.ini" do
  action :delete
end
link "#{node['php']['fpm_conf_dir']}/conf.d/20-pdo_odbc.ini" do
  action :delete
end
link "#{node['php']['fpm_conf_dir']}/conf.d/20-readline.ini" do
  action :delete
end
