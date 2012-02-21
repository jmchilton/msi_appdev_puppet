class glance::install {                                                                   
  $glance_packages = [ "glance-common", "glance", "python-glance", "python-swift" ]       

  user { "glance":
    ensure => present,
    home => "/var/lib/glance",
    shell => "/bin/bash",     
    require => Package['glance']
  }                             

  package { $glance_packages:
    ensure => latest,        
    notify => Service["nova-api"],
    require => [                  
      Package["nova-common"],     
    ]                             
  }                               

  file { "glance-api.conf":
    path => "/etc/glance/glance-api.conf",
    ensure => present,                    
    owner => "glance",                    
    mode => 0600,                         
    content => template("glance/glance-api.conf.erb"),
    notify => Service["glance-api"],                  
    require => [Package["glance"], User["glance"]],   
  }                                                   


  file { "glance-api-paste.ini":
    path => "/etc/glance/glance-api-paste.ini",
    ensure => present,                         
    owner => "glance",                         
    mode => 0600,                              
    content => template("glance/glance-api-paste.ini.erb"),
    notify => Service["glance-api"],                       
    require => [Package["glance"], User["glance"]],        
  }                                                        


  file { "glance-cache.conf":
    path => "/etc/glance/glance-cache.conf",
    ensure => present,                      
    owner => "glance",                      
    mode => 0600,                           
    content => template("glance/glance-cache.conf.erb"),
    notify => Service["glance-api"],                    
    require => [User["glance"], Package["glance"]],     
  }                                                     

  file { "glance-registry.conf":
    path => "/etc/glance/glance-registry.conf",
    ensure => present,                         
    owner => "glance",                         
    mode => 0600,                              
    content => template("glance/glance-registry.conf.erb"),
    notify => Service["glance-registry"],                  
    require => [User["glance"], Package["glance"]],        
  }                                                        

  file { "glance-registry-paste.ini":
    path => "/etc/glance/glance-registry-paste.ini",
    ensure => present,                              
    owner => "glance",                              
    mode => 0600,                                   
    content => template("glance/glance-registry-paste.ini.erb"),
    notify => Service["glance-registry"],                       
    require => [User["glance"], Package["glance"]],             
  }                                                             


  file { "/var/log/glance":
    ensure => directory,   
    owner => "glance",     
    mode => 0755,          
    require => [Package["glance"], Package["python-glance"], User["glance"]]
  }

  file { "/var/log/glance/api.log":
    ensure => present,
    owner => "glance",
    mode => 0600,
    require => [File["/var/log/glance"], User["glance"]],
  }

  file { "/usr/local/bin/keyglance":
    ensure => present,
    owner => 'glance',
    mode => 0755,
    content => template('glance/keyglance.erb'),
    require => [User["glance"]],
  }

  exec { "create_glance_db":
      command => "mysql -uroot -p${mysql_root_password} -e 'create database glance'",
      path => [ "/bin", "/usr/bin" ],
      unless => "mysql -uroot -p${mysql_root_password} -sr -e 'show databases' | grep -q glance",
      notify => Exec["create_glance_user"],
      # this *should* be already done with the require mysql::server, but apparently isn't
      require => [Service['mysql'], Class['mysql::server']]
  }

  exec { "create_glance_user":
    # FIXME:
    # someone really need to get db access limited to just
    # the controller nodes
    command => "mysql -uroot -p${mysql_root_password} -e \"grant all on glance.* to 'glance'@'%' identified by '${mysql_nova_password}'\"",
    path => [ "/bin", "/usr/bin" ],
    notify => Exec["sync_glance_db"],
    require => Service['mysql'],
    refreshonly => true
  }

  # this is all totally brute force
  exec { "sync_glance_db":
    command => "glance-manage db_sync",
    path => [ "/bin", "/usr/bin" ],
    refreshonly => true,
    require => [File["/etc/glance/glance-registry.conf"], Package['glance']]
  }

}


