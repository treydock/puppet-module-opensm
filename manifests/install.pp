# Private class
class opensm::install {
  assert_private()

  package { 'opensm':
    ensure => $opensm::_package_ensure,
    name   => $opensm::package_name,
    notify => $opensm::_notify_service,
  }

}
