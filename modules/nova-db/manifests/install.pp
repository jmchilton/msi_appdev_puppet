class nova-db::install {

  exec { "create_nova_db":
    command => "mysql -uroot -p${mysql_root_password} -e 'create database nova'",
    path => [ "/bin", "/usr/bin" ],
    unless => "mysql -uroot -p${mysql_root_password} -sr -e 'show databases' | grep -q nova",
    notify => Exec["create_nova_user"],
    # this *should* be already done with the require mysql::server, but apparently isn't
    require => [Service['mysql'], Class['mysql::server']]
  }

  exec { "create_nova_user":
    # FIXME:
    # someone really need to get db access limited to just
    # the controller nodes
    command => "mysql -uroot -p${mysql_root_password} -e \"grant all on nova.* to 'nova'@'%' identified by '${mysql_nova_password}'\"",
    path => [ "/bin", "/usr/bin" ],
    notify => Exec["sync_nova_db"],
    require => Service['mysql'],
    refreshonly => true
  }


  # this is all totally brute force
  exec { "sync_nova_db":
    command => "nova-manage db sync",
    path => [ "/bin", "/usr/bin" ],
    refreshonly => true,
#    notify => Exec["create_admin_user"],
    require => [File["/etc/nova/nova.conf"], Package['nova-common']]
  }

}