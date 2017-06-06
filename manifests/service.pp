# Private class
class opensm::service {
  assert_private()

  service { 'opensm':
    ensure     => $opensm::_service_ensure,
    enable     => $opensm::_service_enable,
    name       => $opensm::service_name,
    hasstatus  => true,
    hasrestart => true,
  }

}
