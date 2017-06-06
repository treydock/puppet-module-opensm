shared_examples 'opensm::config' do |facts|

  it 'does not set GUIDS' do
    is_expected.to contain_shellvar('opensm GUIDS').with({
      :ensure   => 'absent',
      :target   => '/etc/sysconfig/opensm',
      :variable => 'GUIDS',
      :value    => nil,
      :notify   => 'Service[opensm]',
    })
  end

  it 'does not set PRIORITY' do
    is_expected.to contain_shellvar('opensm PRIORITY').with({
      :ensure   => 'absent',
      :target   => '/etc/sysconfig/opensm',
      :variable => 'PRIORITY',
      :value    => nil,
      :notify   => 'Service[opensm]',
    })
  end

  context 'when GUIDS set' do
    let(:params) {{ :guids => ['0x1', '0x2'] }}

    it 'sets GUIDS' do
      is_expected.to contain_shellvar('opensm GUIDS').with({
        :ensure   => 'present',
        :target   => '/etc/sysconfig/opensm',
        :variable => 'GUIDS',
        :value    => '0x1 0x2',
        :notify   => 'Service[opensm]',
      })
    end
  end

  context 'when priority set' do
    let(:params) {{ :priority => 15 }}

    it 'sets PRIORITY' do
      is_expected.to contain_shellvar('opensm PRIORITY').with({
        :ensure   => 'present',
        :target   => '/etc/sysconfig/opensm',
        :variable => 'PRIORITY',
        :value    => '15',
        :notify   => 'Service[opensm]',
      })
    end
  end

  context 'when ensure => absent' do
    let(:params) {{ :ensure => 'absent' }}

    it { is_expected.not_to contain_shellvar('opensm GUIDS') }
    it { is_expected.not_to contain_shellvar('opensm PRIORITY') }
  end
end
