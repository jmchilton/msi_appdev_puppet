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

     $compute_nodes = { 
       '00' => { 'mac' => '00:30:48:C4:79:40' },
       '01' => { 'mac' => '00:30:48:7F:C4:1A' },
       '02' => { 'mac' => '00:30:48:7F:C3:4C' },
       '03' => { 'mac' => '00:30:48:7F:C4:32' },
       '04' => { 'mac' => '00:30:48:7F:E0:BC' },
       '05' => { 'mac' => '00:30:48:7F:E4:28' },
       '06' => { 'mac' => '00:30:48:7F:45:B2' },
       '07' => { 'mac' => '00:30:48:7F:2C:1C' },
    }

    include 'management-network'

     #package { memcached: }

     include 'appdev-base'
     include 'bootstrapper'
     #include "nova-infra-node"
     #include "nova-compute-node"
}

node 'spider-services.msi.umn.edu' {
     include 'appdev-base'
}