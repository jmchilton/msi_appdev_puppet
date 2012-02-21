class bootstrapper {
  include dhcp-server
  include tftp
  include bootstrapper::firewall
  include bootstrapper::install
  include bootstrapper::www
}