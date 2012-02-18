class sshd {

  firewall { '100 allow ssh':
    proto       => 'tcp',
    dport       => '22',
    action      => 'accept',
  }

}