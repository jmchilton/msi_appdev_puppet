class quantum-common::install {
  $quantum_common_packages = [ "quantum-common" ]

  package { $quantum_common_packages:
    ensure => latest,
  }

}