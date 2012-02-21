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

     $network = { 
       '-managemnt' => { 'public_ip' => '128.101.191.208', 'management_ip' => '172.0.0.1', },
       '-services' => { 'public_ip' => '128.101.191.209', 'management_ip' => '172.0.0.2',  },
       '00' => { 'public_ip' => '128.101.191.210', 'management_ip' => '172.0.0.100', 'mac' => '00:30:48:C4:79:40' },
       '01' => { 'public_ip' => '128.101.191.211', 'management_ip' => '172.0.0.101', 'mac' => '00:30:48:7F:C4:1A' },
       '02' => { 'public_ip' => '128.101.191.212', 'management_ip' => '172.0.0.102', 'mac' => '00:30:48:7F:C3:4C' },
       '03' => { 'public_ip' => '128.101.191.213', 'management_ip' => '172.0.0.103', 'mac' => '00:30:48:7F:C4:32' },
       '04' => { 'public_ip' => '128.101.191.214', 'management_ip' => '172.0.0.104', 'mac' => '00:30:48:7F:E0:BC' },
       '05' => { 'public_ip' => '128.101.191.215', 'management_ip' => '172.0.0.105', 'mac' => '00:30:48:7F:E4:28' },
       '06' => { 'public_ip' => '128.101.191.216', 'management_ip' => '172.0.0.106', 'mac' => '00:30:48:7F:45:B2' },
       '07' => { 'public_ip' => '128.101.191.217', 'management_ip' => '172.0.0.107', 'mac' => '00:30:48:7F:2C:1C' },
    }

    #include 'management-network'
    management-network( "node-management" : node => "node-management" )

     #package { memcached: }

     include 'appdev-base'
     include 'bootstrapper'
     #include "nova-infra-node"
     #include "nova-compute-node"
}

node 'spider-services.msi.umn.edu' {
     include 'appdev-base'
}