# encoding: UTF-8
directory '/var/www' do
  action :create
end

include_recipe 'nginx::repo'
include_recipe 'nginx::package'

template "#{node['nginx']['dir']}/fastcgi_params" do
  source 'nginx/fastcgi_params.conf.erb'
  notifies :reload, 'service[nginx]'
end

template "#{node['nginx']['dir']}/conf.d/00-tuning.conf" do
  source 'nginx/tuning.conf.erb'
  notifies :reload, 'service[nginx]'
end

template "#{node['nginx']['dir']}/conf.d/01-ssl.conf" do
  source 'nginx/ssl.conf.erb'
  notifies :reload, 'service[nginx]'
end

file "#{node['nginx']['dir']}/conf.d/default.conf" do
  action :delete
  notifies :reload, 'service[nginx]'
end

file "#{node['nginx']['dir']}/conf.d/example_ssl.conf" do
  action :delete
  notifies :reload, 'service[nginx]'
end
