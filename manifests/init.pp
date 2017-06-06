# == Class: opensm
#
# See README.md for more details.
class opensm (
  Enum['present', 'absent'] $ensure = 'present',
  String $package_name              = $opensm::params::package_name,
  Optional[String] $package_ensure  = undef,
  String $service_config_path       = $opensm::params::service_config_path,
  String $service_name              = $opensm::params::service_name,
  Integer[0,15] $priority           = 0,
  Optional[Array] $guids            = undef
) inherits opensm::params {

  case $ensure {
    'present': {
      $_package_ensure = pick($package_ensure, 'present')
      $_notify_service = Service['opensm']
      $_service_ensure = 'running'
      $_service_enable = true
    }
    'absent': {
      $_package_ensure = pick($package_ensure, 'absent')
      $_notify_service = undef
      $_service_ensure = 'stopped'
      $_service_enable = false
    }
    default: {
      fail("Module ${module_name}: ensure must be present or absent, ${ensure} given.")
    }
  }

  contain opensm::install
  contain opensm::config
  contain opensm::service

  if $ensure == 'present' {
    Class['opensm::install']
    -> Class['opensm::config']
    -> Class['opensm::service']
  } elsif $ensure == 'absent' {
    Class['opensm::service']
    -> Class['opensm::config']
    -> Class['opensm::install']
  }

}
