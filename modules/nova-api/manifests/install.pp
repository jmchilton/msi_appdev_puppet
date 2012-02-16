
class nova-api::install {

  package { "nova-api":
    ensure => latest,
  }

  file { "/etc/nova/api-paste.ini":
    ensure => present,
    content => template("nova-api/api-paste.ini.erb"),
    require => [
      Package["nova-api"]
    ]
  }

}

