class mysql::service {
  
  $ensure_value = running
  $enable_value = true
  
  service { "mysql":
    ensure => $ensure_value,
    enable => $enable_value,
    require => Class["mysql::config"]
  }

}