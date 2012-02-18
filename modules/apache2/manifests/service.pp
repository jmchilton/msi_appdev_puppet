class apache2::service {

  service { "apache2": 
    hasrestart => true,
    hasstatus => true,
  }

}