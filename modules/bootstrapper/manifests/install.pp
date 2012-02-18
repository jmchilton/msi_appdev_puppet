class bootstrapper::install {
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

}