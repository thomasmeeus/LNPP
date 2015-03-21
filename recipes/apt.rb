# encoding: UTF-8
include_recipe 'apt::default'

apt_repository 'php' do
  uri 'http://packages.dotdeb.org'
  distribution node['php']['dotdeb_distribution']
  components ['all']
  keyserver 'keys.gnupg.net'
  key '89DF5277'
end.run_action(:add)
