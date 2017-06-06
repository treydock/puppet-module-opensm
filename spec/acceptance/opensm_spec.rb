require 'spec_helper_acceptance'

describe 'opensm class' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'opensm': }
      EOS

      # Will fail without infiniband present
      apply_manifest(pp, :catch_failures => false)
      apply_manifest(pp, :catch_changes => false)
    end

    describe package('opensm') do
      it { should be_installed }
    end

    describe file('/etc/sysconfig/opensm') do
      its(:content) { should_not match /^PRIORITY$/ }
    end

    case fact('operatingsystemmajrelease')
    when /6/
      # Service can't start without IB
      describe service('opensm') do
        it { should_not be_enabled }
        it { should_not be_running }
      end
    when /7/
      describe service('opensm') do
        it { should be_enabled }
        it { should be_running }
      end
    end

  end

  context 'priority defined' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'opensm': priority => 15 }
      EOS

      # Will fail without infiniband present
      apply_manifest(pp, :catch_failures => false)
      apply_manifest(pp, :catch_changes => false)
    end

    describe package('opensm') do
      it { should be_installed }
    end

    describe file('/etc/sysconfig/opensm') do
      its(:content) { should match /^PRIORITY=15$/ }
    end

    case fact('operatingsystemmajrelease')
    when /6/
      # Service can't start without IB
      describe service('opensm') do
        it { should_not be_enabled }
        it { should_not be_running }
      end
    when /7/
      describe service('opensm') do
        it { should be_enabled }
        it { should be_running }
      end
    end

  end

  context 'ensure => absent' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'opensm': ensure => 'absent' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('opensm') do
      it { should_not be_installed }
    end

    describe service('opensm') do
      it { should_not be_enabled }
      it { should_not be_running }
    end

  end
end
