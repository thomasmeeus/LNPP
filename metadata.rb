# encoding: utf-8
name 'LNPP'
description 'Installs and configures a LNPP server based on Debian, Nginx, Percona & PHP-FPM'
maintainer 'Thomas Meeus'
maintainer_email 'thomas@sector7g.be'
license 'MIT'
version '0.1'

%w(debian).each do |os|
  supports os
end

depends 'apt'
depends 'root_ssh_agent'
depends 'openssh'
depends 'nginx'
depends 'munin'
depends 'php'
depends 'percona'
depends 'user'
depends 'ssh_known_hosts'
depends 'openssl'
depends 'composer'
