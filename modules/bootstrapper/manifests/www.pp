class bootstrapper::www {

  file { "/var/www-bootstrap":
    ensure => directory,
  }

  file { "/var/www-bootstrap/post_install.sh":
    content => template('bootstrapper/post_install.sh.erb'),
    require => File["/var/www-bootstrap"],
  }

  file { "/var/www-bootstrap/puppet_credentials.tar.gz":
    source => "puppet:///modules/bootstrapper/files/puppet_credentials.tar.gz",
    require => File["/var/www-bootstrap"],
  }

  file { '/var/www-bootstrap/puppet.conf':
    ensure => link,
    target => '/etc/puppet/puppet.conf',
    require => File["/var/www-bootstrap"],
  }

  apache2::site("172.0.0.1", "/var/www-bootstrap", "bootstrap/bootstrap_site.erb")

}