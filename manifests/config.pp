# Private class
class opensm::config {

  if $opensm::ensure == 'present' {
    shellvar { 'opensm PRIORITY':
      ensure   => 'present',
      target   => $opensm::service_config_path,
      variable => 'PRIORITY',
      value    => $opensm::priority,
      notify   => $opensm::_notify_service,
    }
  }

}
