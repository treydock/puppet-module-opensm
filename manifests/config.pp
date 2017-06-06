# Private class
class opensm::config {
  assert_private()

  if $opensm::ensure == 'present' {
    if $opensm::guids {
      $guids_ensure = 'present'
      $guids_value  = join($opensm::guids, ' ')
    } else {
      $guids_ensure = 'absent'
      $guids_value  = undef
    }

    if $opensm::priority {
      $priority_ensure = 'present'
      $priority_value  = $opensm::priority
    } else {
      $priority_ensure = 'absent'
      $priority_value  = undef
    }

    shellvar { 'opensm GUIDS':
      ensure   => $guids_ensure,
      target   => $opensm::service_config_path,
      variable => 'GUIDS',
      value    => $guids_value,
      notify   => $opensm::_notify_service,
    }

    shellvar { 'opensm PRIORITY':
      ensure   => $priority_ensure,
      target   => $opensm::service_config_path,
      variable => 'PRIORITY',
      value    => $priority_value,
      notify   => $opensm::_notify_service,
    }
  }

}
