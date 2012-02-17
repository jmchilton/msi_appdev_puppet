class sudo::install {

  package { "sudo":
    name   => "sudo",
    ensure => present,
  }

  group { "sudo":
    ensure => present,
  }

}