class bootstrapper::firewall {
  include nat

  firewall { "50 forward puppet":
    table => "nat",
    chain => "PREROUTING",
    iniface => "eth0",
    proto => "tcp",
    source => "172.0.0.0/24",
    dport => "8140",
    jump => "DNAT", 
    todest => "128.101.135.130:8140"
  }

  firewall { "50 forward ntp":
    table => "nat",
    chain => "PREROUTING",
    iniface => "eth0",
    proto => "tcp",
    source => "172.0.0.0/24",
    dport => "123",
    jump => "DNAT",
    todest => "72.14.189.114:123"
  }    

  firewall { "50 snat for management network":
    chain  => 'POSTROUTING',
    jump   => 'MASQUERADE',
    proto  => 'all',
    outiface => "eth1",
    source => '172.0.0.0/24',
    table  => 'nat',
  }

  # If management is otherwise firewalled off at some point (also add):
  # iptables -A INPUT -p tcp -m state --state NEW --dport 8140 -i eth0 --source 172.0.0.0/24 -j ACCEPT

}
