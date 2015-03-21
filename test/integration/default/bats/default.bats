#!/usr/bin/env bats

@test "Test if hostname is set to 'server01'" {
  grep -q  "server01" /etc/hostname
}

@test "Test if `hostname -f` returns the FQDN 'server01.test.dev'" {
  hostname -f | grep -q server01.dev
}

@test "Test if during sudo the ENV gets preserved" {
  grep "Defaults env_keep+=\"SSH_AUTH_SOCK\"" /etc/sudoers.d/root_ssh_agent
}

@test "Test if SSH-daemon is running on port 22345" {
  grep '^Port 22345' /etc/ssh/sshd_config
}

@test "Test if SSH root-logins are disabled" {
  grep '^PermitRootLogin no' /etc/ssh/sshd_config
}

@test "Test if UseDNS is set to no" {
  grep '^UseDns no' /etc/ssh/sshd_config
}

@test "Test if SSH-agent forwarding is enabled" {
  grep 'ForwardAgent yes' /etc/ssh/ssh_config
}
