#
# Cookbook Name:: ninja
# Recipe:: default
#
# Copyright (C) 2014 Andre Weissflog 
# 
include_recipe "apt"
include_recipe "python"
include_recipe "git"

package "build-essential"

cache_path = Chef::Config['file_cache_path']
repo = node['ninja']['url']
branch = node['ninja']['branch']

# git-clone to branch name "release"
git "#{cache_path}/ninja" do 
    repository "#{repo}"
    revision "#{branch}"
    action :export
    notifies :run, "bash[build_ninja]"
end

# ...build it...
bash "build_ninja" do
    cwd "#{cache_path}/ninja"
    code <<-EOH
    ./bootstrap.py    
    EOH
    action :nothing
    notifies :create, "link[create_link]"
end

# ...create link...
link "create_link" do
    target_file "/usr/local/bin/ninja"
    to "#{cache_path}/ninja/ninja"
    action :nothing
end


