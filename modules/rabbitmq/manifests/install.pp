class rabbitmq::install {
  group { 'rabbitmq':
    ensure => present,
  }

  user { 'rabbitmq':
    ensure => present,
    gid => 'rabbitmq',
    home => '/var/lib/rabbitmq',
    shell => '/bin/false',
    require => Group['rabbitmq']
  }
    
  package { "rabbitmq-server":
    ensure => present,
    require => User['rabbitmq']
  }

}