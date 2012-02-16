class nova-common::config {

  file { "/etc/nova/nova.conf":
    ensure => present,
    owner => "nova",
    group => "nogroup",
    mode => 0660,
    content => template("nova-common/nova.conf.erb"),
    require => Package["nova-common"]
  }

}