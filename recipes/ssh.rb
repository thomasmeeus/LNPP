# encoding: UTF-8

include_recipe 'ssh_known_hosts::default'
include_recipe 'openssh::default'
include_recipe 'root_ssh_agent::ppid'
include_recipe 'root_ssh_agent::env_keep'

ssh_known_hosts_entry 'github.com'
