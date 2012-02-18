import "sitedefs.pp"
import "credentials.pp"

node 'spider.msi.umn.edu' {
     $nova_admin_user = "admin"
     $api_vip = "spider.msi.umn.edu"
     $mysql_vip = "localhost"
     $rabbit_vip = "spider.msi.umn.edu"
     $keystone_vip = "spider.msi.umn.edu"
     $glance_vip = "spider.msi.umn.edu"
     $network_manager = "FlatDHCPManager"
     $fixed_range = "10.1.0.0/16"
     $flat_interface = "br100"
     $dhcp_start= "10.1.0.2"
     $newtork_host = "spider"
     $public_interface = "eth0"
     #package { memcached: }

     include 'appdev-base'
     #include "nova-infra-node"
     #include "nova-compute-node"
}

node 'spider-services.msi.umn.edu' {
     include 'appdev-base'
}