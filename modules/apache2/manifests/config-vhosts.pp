class apache2::config-vhosts {

  file { "/etc/apache2/conf.d/name-based-vhosts.conf":
    content => "NameVirtualHost *:80",
    require => Package["apache2"],
    notify => Service["apache2"],
  }  

}