class rabbitmq::service { 
  $ensure_value = running
  $enable_value = true

  service { "rabbitmq-server":
    ensure => $ensure_value,
    enable => $enable_value,
    hasstatus => true,
    require => Class['rabbitmq::install']
  }

}