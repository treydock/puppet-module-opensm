# Private class
class opensm::install {

  package { 'opensm':
    ensure => $opensm::_package_ensure,
    name   => $opensm::package_name,
    notify => $opensm::_notify_service,
  }

}
