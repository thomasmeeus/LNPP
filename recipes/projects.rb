# encoding: UTF-8
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node['projects'].each do |project|
  hostsfile_entry '127.0.0.1' do
    hostname project
    action :append
  end

  user project do
    action :create
    home "/var/www/#{project}"
    system true
    supports :manage_home => true
  end

  directory "/var/www/#{project}/webroot" do
    action :create
    recursive true
    user project
    group project
  end

  directory "#{node['nginx']['log_dir']}/#{project}"

  directory node['php']['fpm_pool_dir'] do
    action :create
    recursive true
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

  if run_context.has_template_in_cookbook?(cookbook_name, "nginx/vhosts/#{project}.conf.erb")
    template "#{node['nginx']['dir']}/sites-available/#{project}.conf" do
      source "nginx/vhosts/#{project}.conf.erb"
    end
  else
    template "#{node['nginx']['dir']}/sites-available/#{project}.conf" do
      source 'nginx/vhosts/default.conf.erb'
      action :create_if_missing
      variables(:project => project, :docroot => "/var/www/#{project}/webroot", :hostname => "#{project} #{project}.#{node['fqdn']}")
    end
  end

  password = secure_password

  template "/var/www/#{project}/.README" do
    source 'readme.erb'
    action :create_if_missing
    variables(:project => project, :docroot => "/var/www/#{project}/webroot", :mysqlpassword => password)
    user project
    group project
    mode '0400'
  end

  execute "mysql -u root -p#{node['percona']['server']['root_password']} -e 'create database #{project}'" do
    not_if "mysql -u root -p#{node['percona']['server']['root_password']} --skip-column-names --batch -e  'show databases' | grep '#{project}'"
  end

  execute "mysql -u root -p#{node['percona']['server']['root_password']} -e \"GRANT ALL PRIVILEGES ON #{project}.* TO '#{project}'@'localhost' IDENTIFIED BY '#{password}'; \"" do
    not_if "mysql -u root -p#{node['percona']['server']['root_password']} --skip-column-names --batch -e 'select * from mysql.user where user=#{project}'"
  end

  template "/var/www/#{project}/webroot/index.php" do
    action :create_if_missing
    source 'index.php.erb'
    user project
    group project
  end

  execute "nxensite #{project}.conf"
end

service 'nginx' do
  action :reload
end
