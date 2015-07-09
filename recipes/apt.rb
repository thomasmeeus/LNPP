# encoding: UTF-8
include_recipe 'apt::default'

apt_repository 'php' do
  uri 'http://packages.dotdeb.org'
  distribution node['php']['dotdeb_distribution']
  components ['all']
  key 'http://www.dotdeb.org/dotdeb.gpg'
end.run_action(:add)
