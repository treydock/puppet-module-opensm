require 'beaker-rspec'

install_puppet_on(hosts, {:version => '3.8.3'})

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'opensm')

    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs/stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'domcleal/augeasproviders'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
