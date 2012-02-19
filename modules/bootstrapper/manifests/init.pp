class bootstrapper {
  include apache2
  include bootstrapper::install, bootstrapper::service
}