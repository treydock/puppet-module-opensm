shared_examples 'opensm::config' do |facts|

  it 'sets PRIORITY' do
    is_expected.to contain_shellvar('opensm PRIORITY').with({
      :ensure   => 'present',
      :target   => '/etc/sysconfig/opensm',
      :variable => 'PRIORITY',
      :value    => '0',
      :notify   => 'Service[opensm]',
    })
  end

  context 'when ensure => absent' do
    let(:params) {{ :ensure => 'absent' }}

    it { is_expected.not_to contain_shellvar('opensm PRIORITY') }
  end
end
