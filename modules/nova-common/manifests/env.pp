# Class creates a file /nova/nova_env.sh that can be sourced to
# configure the admin's nova environment.

class nova-common::env {

  file { "/root/nova_env.sh":
    content => template('nova-common/nova_env.sh.erb'),
  }
}