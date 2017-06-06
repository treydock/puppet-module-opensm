# == Class: opensm
#
# See README.md for more details.
class opensm (
  $ensure                  = 'present',
  $package_name            = $opensm::params::package_name,
  $package_ensure          = undef,
  $service_config_path     = $opensm::params::service_config_path,
  $service_name            = $opensm::params::service_name,
  $priority                = 0,
) inherits opensm::params {

  validate_numeric($priority, 15, 0)

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

  include opensm::install
  include opensm::config
  include opensm::service

  anchor { 'opensm::start': }
  anchor { 'opensm::end': }

  if $ensure == 'present' {
    Anchor['opensm::start']
    -> Class['opensm::install']
    -> Class['opensm::config']
    -> Class['opensm::service']
    -> Anchor['opensm::end']
  } elsif $ensure == 'absent' {
    Anchor['opensm::start']
    -> Class['opensm::service']
    -> Class['opensm::config']
    -> Class['opensm::install']
    -> Anchor['opensm::end']
  }

}
