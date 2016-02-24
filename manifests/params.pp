# The opensm default configuration settings.
class opensm::params {

  case $::osfamily {
    'RedHat': {
      $package_name         = 'opensm'
      $service_config_path  = '/etc/sysconfig/opensm'
      $service_name         = 'opensm'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only supports osfamily RedHat")
    }
  }

}
