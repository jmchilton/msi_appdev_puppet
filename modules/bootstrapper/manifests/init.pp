class bootstrapper {
  require apache2
  include bootstrapper::install, bootstrapper::service
}