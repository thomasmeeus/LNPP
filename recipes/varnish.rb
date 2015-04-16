# encoding: UTF-8

include_recipe 'varnish::default'

cookbook_file 'clear_varnish' do
  path '/bin/clear_varnish'
  action :create
  mode 0755
end
