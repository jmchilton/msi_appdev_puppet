class apache2::install {

  package { "apache2":
    ensure => latest,
  }

}