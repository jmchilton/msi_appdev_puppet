class apache2 {
  include apache2::install, apache2::service, apache2::config-vhosts

  define site($sitedomain = "", $documentroot = "", $vhosttemplate = "") {
    include apache2 

    if $sitedomain == "" {
      $vhost_domain = $name
    } else {
      $vhost_domain = $sitedomain
    }

    if $documentroot == "" {
      $vhost_root = "/var/www/${name}"
    } else {
      $vhost_root = $documentroot
    }

    if $vhosttemplate == "" {
      $vhosttemplate = "apache/vhost.erb"
    }

    file { "/etc/apache2/sites-available/${vhost_domain}.conf":
      content => template($vhosttemplate),
      require => File["/etc/apache2/conf.d/name-based-vhosts.conf"],
      notify => Exec["enable-${vhost_domain}-vhost"],
    }

    exec { "enable-${vhost_domain}-vhost":
      command => "/usr/sbin/a2ensite ${vhost_domain}.conf",
      require => [ File["/etc/apache2/sites-available/${vhost_domain}.conf"],
                   Package["apache2"]],
      refreshonly => true,
      notify => Service["apache2"],
    }

  }

}

