class tftp::install {

  package { "tftpd-hpa":
    ensure => latest,
    require => File['tftpd-hpa']
  }

  file { "tftpd-hpa":
    path => "/etc/default/tftpd-hpa",
    content => template('tftp/tftpd-hpa.erb'),
  }

  file { "/srv/tftpboot":
    ensure => directory,
  }

}