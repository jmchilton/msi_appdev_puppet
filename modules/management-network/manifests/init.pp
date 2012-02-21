
class management-network {
  file { "/etc/hosts-fake": 
    content => template("management-network/hosts.erb"),
  }


}