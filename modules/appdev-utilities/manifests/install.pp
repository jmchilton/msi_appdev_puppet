class appdev-utilities::install {
  $appdev_utility_packages = ["emacs23-nox", "wajig"]

  package { $appdev_utility_packages:
    require: latest
  }

}