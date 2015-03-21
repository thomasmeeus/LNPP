#!/usr/bin/env bats

@test "Test if the vim-package is installed" {
  dpkg --get-selections | grep -q vim
}

@test "Test if the apache2-utils-package is installed" {
  dpkg --get-selections | grep -q apache2-utils
}

@test "Test if the git-package is installed" {
  dpkg --get-selections | grep -q git
}

@test "Test if the bc-package is installed" {
  dpkg --get-selections | grep -q bc
}

@test "Test if the libwww-perl-package is installed" {
  dpkg --get-selections | grep -q libwww-perl
}

@test "Test if the htop-package is installed" {
  dpkg --get-selections | grep -q htop
}

@test "Test if the iotop-package is installed" {
  dpkg --get-selections | grep -q iotop
}

@test "Test if the iftop-package is installed" {
  dpkg --get-selections | grep -q iftop
}
