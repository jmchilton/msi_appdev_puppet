class quantum-server::install {
  $quantum_server_packages = [ "quantum-server", "openvswitch-switch", "quantum-plugin-openvswitch" ]

  package { $quantum_server_packages:
    ensure => latest,
  }

} 