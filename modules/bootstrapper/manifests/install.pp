class bootstrapper::install {
  include apt-cacher-ng

  file { "configure_installer.sh":
    path => "/srv/tftpboot/configure_installer.sh",
    content => template('bootstrapper/configure_installer.sh.erb'),
    require => File["/srv/tftpboot"],
    mode => 0700,
  }

  exec { "configure_installer":
    command => "/srv/tftpboot/configure_installer.sh",
    path => [ "/bin", "/usr/bin" ],
    creates => "/srv/tftpboot/rebuild_image.sh",
    subscribe => File["configure_installer.sh"],
  }

  file { "preseed.cfg":
    path => "/srv/tftpboot/init-root/preseed.cfg",
    content => template('bootstrapper/preseed.cfg.erb'),
    subscribe => Exec["configure_installer"],
    require => Exec["configure_installer"],
  } 

  file { "pxelinux.cfg":
    path => "/srv/tftpboot/pxelinux.cfg/default",
    content => template("bootstrapper/pxelinux.cfg.erb"),
    subscribe => Exec["configure_installer"],
    require => Exec["configure_installer"],
  }


  exec { "build_installer":
    command => "/srv/tftpboot/rebuild_image.sh",
    path => [ "/bin", "/usr/bin" ],
    subscribe => File["preseed.cfg"],
    refreshonly => true,
  }

}