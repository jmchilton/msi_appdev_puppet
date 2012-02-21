class bootstrapper::install {
  include apt-cacher-ng

  $bootstrapper_packages = ["tftpd-hpa", "dhcp3-server"]

  package { $bootstrapper_packages:
    ensure => latest,
    require => File['tftpd-hpa']
  }

  file { "tftpd-hpa":
    path => "/etc/default/tftpd-hpa",
    content => template('bootstrapper/tftpd-hpa.erb'),
  }

  file { "/srv/tftpboot":
    ensure => directory,
  }

  file { "/etc/dhcp":
    ensure => directory,
  }

  file { "dhcpd.conf":
    path => "/etc/dhcp/dhcpd.conf",
    content => template('bootstrapper/dhcpd.conf.erb'),
    require => File['/etc/dhcp'],
    notify => Service['isc-dhcp-server']
  }

  file { "isc-dhcp-server":
    path => "/etc/default/isc-dhcp-server",
    content => template('bootstrapper/isc-dhcp-server-defaults.erb'),
    notify => Service['isc-dhcp-server']
  }

  file { "configure_installer.sh":
    path => "/srv/tftpboot/configure_installer.sh",
    content => template('bootstrapper/configure_installer.sh.erb'),
    require => File["/srv/tftpboot"],
  }

  exec { "configure_installer":
    command => "/srv/tftpboot/configure_installer.sh"
    path => [ "/bin", "/usr/bin" ],
    creates => "/srv/tftpboot/rebuild_image.sh",
    require => File["configure_installer.sh"],
  }

  file { "preseed.cfg":
    path => "/srv/tftpboot/init-root/preseed.cfg",
    content = template('bootstrapper/preseed.cfg.erb'),
    require => Exec["configure_installer"],
  } 

  exec { "build_installer":
    command => /srv/tftpboot/rebuild_image.sh",
    subscribe = File["preseed.cfg"],
    refreshonly => true,
  }

  file { "/var/www-bootstrap":
    ensure => directory,    
  }

  file { "/var/www-bootstrap/post_install.sh"
    content => template('bootstrapper/post_install.sh.erb'),
    require => File["/var/www-bootstrap"],
  }

  file { "/var/www-bootstrap/puppet_credentials.tar.gz":
    source => "puppet:///modules/bootstrapper/files/puppet_credentials.tar.gz",
    require => File["/var/www-bootstrap"],
  }

  file { '/var/www-bootstrap/puppet.conf':
    ensure => link,
    target => '/etc/puppet/puppet.conf',
    require => File["/var/www-bootstrap"],
  }

  apache::site("172.0.0.1", "/var/www-bootstrap", "bootstrap/bootstrap_site.erb")




}