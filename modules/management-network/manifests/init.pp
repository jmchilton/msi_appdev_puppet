class management-network {

  file { "/etc/hosts-fake":
    content => template("management-network/hosts.erb"),
  }

  file { "/etc/network/interfaces-fake":
    content => template("management-network/interfaces.erb"),
  }

}
