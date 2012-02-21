import "sitedefs.pp"
import "credentials.pp"

     $network = {
       'node-management' => { 'hostname' => 'spider', 'public_ip' => '128.101.191.208', 'management_ip' => '172.0.0.1' },
       'node-services' => { 'hostname' => 'spider-services', 'public_ip' => '128.101.191.209', 'management_ip' => '172.0.0.2'  },
       'node00' => { 'hostname' => 'spider00', 'public_ip' => '128.101.191.210', 'management_ip' => '172.0.0.100', 'mac' => '00:30:48:C4:79:40' },
       'node01' => { 'hostname' => 'spider01', 'public_ip' => '128.101.191.211', 'management_ip' => '172.0.0.101', 'mac' => '00:30:48:7F:C4:1A' },
       'node02' => { 'hostname' => 'spider02', 'public_ip' => '128.101.191.212', 'management_ip' => '172.0.0.102', 'mac' => '00:30:48:7F:C3:4C' },
       'node03' => { 'hostname' => 'spider03', 'public_ip' => '128.101.191.213', 'management_ip' => '172.0.0.103', 'mac' => '00:30:48:7F:C4:32' },
       'node04' => { 'hostname' => 'spider04', 'public_ip' => '128.101.191.214', 'management_ip' => '172.0.0.104', 'mac' => '00:30:48:7F:E0:BC' },
       'node05' => { 'hostname' => 'spider05', 'public_ip' => '128.101.191.215', 'management_ip' => '172.0.0.105', 'mac' => '00:30:48:7F:E4:28' },
       'node06' => { 'hostname' => 'spider06', 'public_ip' => '128.101.191.216', 'management_ip' => '172.0.0.106', 'mac' => '00:30:48:7F:45:B2' },
       'node07' => { 'hostname' => 'spider07', 'public_ip' => '128.101.191.217', 'management_ip' => '172.0.0.107', 'mac' => '00:30:48:7F:2C:1C' },
     }

     $nova_admin_user = "admin"
     $api_vip = "node-services"
     $mysql_vip = "node-services"
     $rabbit_vip = "node-services"
     $keystone_vip = "node-services"
     $glance_vip = "node-services"
     $network_manager = "FlatDHCPManager"
     $fixed_range = "172.1.0.0/16"
     $flat_interface = "eth0"
     $dhcp_start= "172.1.0.0"
     $newtork_host = "node-services"
     $public_interface = "eth1"

node 'spider.msi.umn.edu' {
     $network_node = 'node-management'

     include 'management-network'
     include 'appdev-base'
     include 'bootstrapper'

     #include "nova-infra-node"
     #include "nova-compute-node"
}

node 'spider-services.msi.umn.edu' {
     $network_node = 'node-services'  

     include 'appdev-base'
     include 'management-network'
     include 'nova-infra-node'
}

node /^spider\d+.msi.umn.edu/ {
     $network_node = regsubst($hostname, 'spider(\d+)', 'node\1')
     include 'appdev-base'
     include 'management-network'
     include 'nova-compute-node'
}



