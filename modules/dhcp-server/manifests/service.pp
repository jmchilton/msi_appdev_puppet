class dhcp-server::service {

  service { "isc-dhcp-server":
    subscribe => File["dhcpd.conf"],
    hasrestart => true,
    hasstatus => true,
  }

}