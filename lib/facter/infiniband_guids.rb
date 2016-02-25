# Fact: infiniband_guids
#
# Purpose: Return Infiniband GUIDs of system
#
# Resolution:
#   Returns comma separated list of GUIDs
#
# Caveats:
#   Requires ibstat be present
#

#require 'facter/core/execution'

Facter.add(:infiniband_guids) do
  confine :kernel => "Linux"
  setcode do
    value = nil
    ibstat = Facter::Core::Execution.which('ibstat')
    if ibstat
      ibstat_p = Facter::Core::Execution.exec("#{ibstat} -p 2>/dev/null")
      unless ibstat_p.nil? || ibstat_p.empty?
        value = ibstat_p.split(/\n/).join(',')
      end
    end

    value
  end
end
