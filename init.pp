#/*
# *
# * Licensed to the Apache Software Foundation (ASF) under one
# * or more contributor license agreements.  See the NOTICE file
# * distributed with this work for additional information
# * regarding copyright ownership.  The ASF licenses this file
# * to you under the Apache License, Version 2.0 (the
# * "License"); you may not use this file except in compliance
# * with the License.  You may obtain a copy of the License at
# *
# *   http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing,
# * software distributed under the License is distributed on an
# * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# * KIND, either express or implied.  See the License for the
# * specific language governing permissions and limitations
# * under the License.
# *
#*/

###############################################################################
# Defaults
###############################################################################

Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }

file { "/vagrant_www/home":
    ensure => directory,
    mode => 0775,
}

###############################################################################
# Jenkins
###############################################################################

class { 'java': }

class { 'jenkins':
  require => Package['java'],
}

# Install plugin by hand @see https://wiki.jenkins-ci.org/display/JENKINS/Plugins#Plugins-Byhand
# You may add your plugins as you wish
jenkins::plugin {
  'ruby':;
}

###############################################################################
# Packages
###############################################################################

package { 'firefox':
  ensure => installed
}

package { 'xorg-x11-server-Xvfb':
  ensure => installed
}

exec { 'Yum Group Install X Window System':
  unless => 'yum grouplist "X Window System" | grep "^Installed Groups"',
  command => 'yum -y groupinstall "X Window System"',
  path => ['/usr/bin/', '/bin/']
}

exec { 'Yum Group Install Desktop':
  unless => 'yum grouplist "Desktop" | grep "^Installed Groups"',
  command => 'yum -y groupinstall "Desktop"',
  path => ['/usr/bin/', '/bin/']
}

exec { 'Yum Group Install Fonts':
  unless => 'yum grouplist "Fonts" | grep "^Installed Groups"',
  command => 'yum -y groupinstall "Fonts"',
  path => ['/usr/bin/', '/bin/']
}

exec { 'Yum Group Install General Purpose Desktop':
  unless => 'yum grouplist "General Purpose Desktop" | grep "^Installed Groups"',
  command => 'yum -y groupinstall "General Purpose Desktop"',
  path => ['/usr/bin/', '/bin/']
}
