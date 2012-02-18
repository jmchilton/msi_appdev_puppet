import "sitedefs.pp"

node 'appdev-dom0.msi.umn.edu' {
     $nova_admin_user = "admin"
     $api_vip = "appdev-dom0.msi.umn.edu"
     $mysql_vip = "localhost"
     $rabbit_vip = "appdev-dom0.msi.umn.edu"
     $keystone_vip = "appdev-dom0.msi.umn.edu"
     $glance_vip = "appdev-dom0.msi.umn.edu"
     $network_manager = "FlatDHCPManager"
     $fixed_range = "10.1.0.0/16"
     $flat_interface = "br100"
     $dhcp_start= "10.1.0.2"
     $newtork_host = "appdev-dom0"
     $public_interface = "eth0"
     package { memcached: }

     include "debootstrap"
     include "nova-infra-node"
     include "nova-compute-node"
}