class nova-scheduler::service {

  service { "nova-scheduler":
    ensure => running,
    enable => true,
    require => Class["nova-scheduler::install"]
  }
  
}