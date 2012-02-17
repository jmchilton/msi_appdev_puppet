

class base-node {
  include sysctl
  include appdev_users
}

class nova-base-node {
  include base-node
  include nova-common
}

class nova-compute-node {
  include nova-base-node
  include nova-compute
}

class nova-infra-node {
  include nova-base-node

  # data services
  include rabbitmq
  include mysql::server

  # database setup
  include nova-db

  # openstack services
  include nova-api
  include nova-scheduler

  include glance
  include keystone
  include nova-network
}

