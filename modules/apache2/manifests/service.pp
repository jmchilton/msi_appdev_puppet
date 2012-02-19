class apache2::service {

  service { "apache2": 
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["apache2"],
  }

}