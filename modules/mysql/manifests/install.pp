class mysql::install {

  group { 'mysql':
    ensure => present,
  }
  
  user { 'mysql':
    ensure => present,
    gid => 'mysql',
    home => '/var/lib/mysql',
    shell => '/bin/false',
    require => Group['mysql']
  }


  file { "/var/local/mysql-server.preseed":
    content => template('mysql/mysql-preseed.erb'),
    mode => 600,
    backup => false,
  }

  package { "mysql-server-5.1":
    ensure => $ensure,
    responsefile => "/var/local/mysql-server.preseed",
    require => File["/var/local/mysql-server.preseed"],
  }

}
