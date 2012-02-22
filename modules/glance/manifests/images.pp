class glance::images {
  include glance::config

  file { "initial_images.sh":
    path => "${glance::config::home}/initial_images.sh",
    ensure => present,
    owner => "glance",
    mode => 0700,
    content => template("glance/initial_images.sh.erb"),
    require => Package["glance"]
  }
  
}
