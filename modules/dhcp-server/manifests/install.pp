class dhcp-server::install {
  package { "dhcp3-server" :  # TODO: Pick actual isc package instead
    ensure => present,
  }

  file { "/etc/dhcp":
    ensure => directory,
  }

  file { "dhcpd.conf":
    path => "/etc/dhcp/dhcpd.conf",
    content => template('dhcp-server/dhcpd.conf.erb'),
    require => [File['/etc/dhcp'], Package["dhcp3-server"]],
    notify => Service['isc-dhcp-server']
  }

  file { "isc-dhcp-server":
    path => "/etc/default/isc-dhcp-server",
    content => template('dhcp-server/isc-dhcp-server-defaults.erb'),
    notify => Service['isc-dhcp-server']
  }

}