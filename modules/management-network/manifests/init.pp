
def management-network ( $node ) {
  file { "/etc/hosts-fake": 
    content => template("management-network/hosts.erb"),
  }

  file { "/etc/networking/interfaces-fake":
    content => template("management-network/interfaces.erb"),
  }

}