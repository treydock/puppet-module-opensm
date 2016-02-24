# puppet-opensm

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/opensm.svg)](https://forge.puppetlabs.com/treydock/opensm)
[![Build Status](https://travis-ci.org/treydock/puppet-module-opensm.svg?branch=master)](https://travis-ci.org/treydock/puppet-module-opensm)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
    * [Public Classes](#public-classes)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the OpenSM InfiniBand Subnet Manager.

## Usage

### opensm

Standard usage to enable OpenSM

    class { 'opensm': }

Set OpenSM with a specific priority

    class { 'opensm':
      priority  => 15,
    }

## Reference

* [Public Classes](#public-classes)
  * [Class: opensm](#class-opensm)
* [Private Classes](#private-classes)
* [Facts](#facts)

### Public classes

#### Class: `opensm`:

Installs and configures OpenSM

Default values in Hiera format:

$::osfamily == 'RedHat'

    opensm::ensure: 'present'
    opensm::package_name: 'opensm'
    opensm::service_config_path: '/etc/sysconfig/opensm'
    opensm::service_name: 'opensm'
    opensm::priority: 0

#####`ensure`

Valid values are `present` and `absent`.  Default is `present`

#####`package_name`

OpenSM package name.  Default is OS dependent.

#####`package_ensure`

This value is passed to the Package[opensm] ensure.  The default value is determined based on `opensm::ensure` value.

#####`service_config_path`

OpenSM service configuration path.  Default is OS dependent.

#####`service_name`

OpenSM service name.  Default is OS dependent.

#####`priority`

OpenSM priority.  Default is `0`.  Valid values are integers 0 through 15.

### Private classes

* `opensm::install`: Installs the opensm packages.
* `opensm::config`: Manages opensm configuration.
* `opensm::service`: Manages the opensm service.
* `opensm::params`: Sets default values based on facts.

### Facts

#### infiniband_guids

System's IB GUIDs.  Multiple GUIDs are separated by commas.

## Limitations

Supports the following operating systems:

* RedHat/CentOS 6
* RedHat/CentOS 7

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker
