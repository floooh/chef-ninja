# encoding: UTF-8
#
# Cookbook Name:: ninja
# Recipe:: default
#
# Copyright (C) 2014 Andre Weissflog
#
include_recipe 'build-essential'
include_recipe 'apt'
include_recipe 'python'
include_recipe 'git'

repo = node['ninja']['url']
branch = node['ninja']['branch']

# git-clone to branch name "release"
git '/opt/ninja' do
  repository repo
  revision branch
  action :export
  notifies :run, 'bash[build_ninja]'
end

# ...build it...
bash 'build_ninja' do
  cwd '/opt/ninja'
  code <<-EOH
  ./bootstrap.py
  EOH
  action :nothing
  notifies :create, 'link[create_link]'
end

# ...create link...
link 'create_link' do
  target_file '/usr/local/bin/ninja'
  to '/opt/ninja/ninja'
  action :nothing
end
