class management-network {

  file { "/etc/hosts":
    content => template("management-network/hosts.erb"),
  }

  file { "/etc/network/interfaces":
    content => template("management-network/interfaces.erb"),
  }

}
