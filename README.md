### Description ###

Installs most uptodate release version of ninja (the build system).

What happens under the hood:

* git clone from git://github.com/martine/ninja.git to /var/chef/cache/ninja
* run ninja/bootstrap.py
* setup a symbolic link in /usr/local/bin/ninja

### Requirements ###
#### Platform: ####

* Ubuntu/Debian

#### Dependencies ####

* python
* git
* apt

### Attributes ###
#### Default recipe attributes: ####

* `node['ninja']['url']` - the git url (default: git://github.com/martine/ninja.git)
* `node['ninja']['branch']` - the branch name to checkout (default: release)

### Author ####
Author:: Andre Weissflog (floooh@gmail.com)
