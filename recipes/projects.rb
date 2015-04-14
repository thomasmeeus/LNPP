# encoding: UTF-8
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node['projects'].each do |project|
  directory "/var/www/#{project}/webroot" do
    action :create
    recursive true
  end

  directory "#{node['nginx']['log_dir']}/#{project}" do
    action :create
  end

  user project do
    action :create
    home "/var/www/#{project}/webroot"
    system true
    supports :manage_home => true
  end

  php_fpm project do
    action :add
    user project
    group project
    socket_user 'www-data'
    socket_group 'www-data'
    socket true
    socket_path "/tmp/#{project}.sock"
    socket_perms '0660'
    start_servers 2
    min_spare_servers 2
    max_spare_servers 8
    max_children 8
    value_overrides(
      :error_log => "#{node['nginx']['log_dir']}/#{project}/error.log"
    )
  end

  template "#{node['nginx']['dir']}/sites-available/#{project}.conf" do
    source 'nginx/default_project.conf.erb'
    action :create_if_missing
    variables(:project => project, :hostname => "#{project}.#{node['fqdn']}")
  end

  password = secure_password

  template "/var/www/#{project}/.README" do
    source 'readme.erb'
    action :create_if_missing
    variables(:project => project, :docroot => "/var/www/#{project}/webroot", :mysqlpassword => node['password'])
  end

  execute "mysql -u root -p#{node['percona']['server']['root_password']} -e 'create database #{project}'" do
    not_if "mysql -u root -p#{node['percona']['server']['root_password']} --skip-column-names --batch -e  'show databases' | grep '#{project}'"
  end

  execute "mysql -u root -p#{node['percona']['server']['root_password']} -e \"GRANT ALL PRIVILEGES ON #{project}.* TO '#{project}'@'localhost' IDENTIFIED BY '#{password}'; \"" do
    not_if "mysql -u root -p#{node['percona']['server']['root_password']} --skip-column-names --batch -e 'select * from mysql.user where user=#{project}'"
  end

  template "/var/www/#{project}/webroot/index.php" do
    source 'index.php.erb'
  end

  execute "nxensite #{project}.conf"
end

service 'nginx' do
  action :restart
end