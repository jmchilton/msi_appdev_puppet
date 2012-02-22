class keystone::install {                                                                   
  user { "keystone":
    ensure => present,
    home => "/var/lib/keystone",
    shell => "/bin/bash",       
    require => Package["keystone"],
  }                                

  package { "keystone":
    ensure => present,  
    notify => [Service["nova-api"]],
    require => [                    
      Package["nova-common"],       
    ],
  }

  file { "/var/log/keystone":
    ensure => directory,     
    owner => "keystone",     
    mode => 0755,            
    require => [User["keystone"], Package["keystone"]],
  }                                                   

  file { "keystone.conf":
    path => "/etc/keystone/keystone.conf",
    ensure => present,                    
    owner => "keystone",                  
    mode => 0600,                         
    content => template("keystone/keystone.conf.erb"),
    notify => Service["keystone"],                    
    require => [User["keystone"], Package["keystone"]],
  }                                                   

  file { "add-keystone-user.sh":
    path => "/var/lib/keystone/add-keystone-user.sh",
    ensure => present,                               
    owner => "keystone",                             
    mode => 0700,                                    
    source => "puppet:///modules/keystone/add-keystone-user.sh",
    notify => Service["keystone"],                              
    require => [User["keystone"], Package["keystone"]],         
  }                                                             

  file { "initial_data.sh":
    path => "/var/lib/keystone/initial_data.sh",
    ensure => present,                          
    owner => "keystone",                        
    mode => 0700,
    content => template("keystone/initial_data.sh.erb"),
    require => [User["keystone"], Package["keystone"]],
  }

  exec { "create_keystone_db":
    command => "mysql -uroot -p${mysql_root_password} -e 'create database keystone'",
    path => [ "/bin", "/usr/bin" ],
    unless => "mysql -uroot -p${mysql_root_password} -sr -e 'show databases' | grep -q keystone",
    notify => Exec["create_keystone_user"],
    # this *should* be already done with the require mysql::server, but apparently isn't
    require => Class['mysql::server'],
  }

  exec { "create_keystone_user":
    command => "mysql -uroot -p${mysql_root_password} -e \"grant all on keystone.* to 'keystone'@'%' identified by '${mysql_nova_password}'\"",
    path => [ "/bin", "/usr/bin" ],
    notify => Exec["sync_keystone_db"],
    require => Class["mysql::server"],
    refreshonly => true,
  }


  # this is all totally brute force
  exec { "sync_keystone_db":
    command => "keystone-manage db_sync",
    path => [ "/bin", "/usr/bin" ],
    notify => Exec["create_keystone_data"],
    refreshonly => true,
    require => [File["/etc/keystone/keystone.conf"], Package['keystone'], Exec["create_keystone_user"]],
  }

  exec { "create_keystone_data":
    user => "keystone",
    command => "/var/lib/keystone/initial_data.sh",
    path => [ "/bin", "/usr/bin" ],
    unless => "keystone-manage user list | grep -q admin",
    require => [
      Package["keystone"],
      File["keystone.conf"],
      File["initial_data.sh"],
      Exec["sync_keystone_db"],
    ],
  }

}
