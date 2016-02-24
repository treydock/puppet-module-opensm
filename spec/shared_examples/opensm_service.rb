shared_examples 'opensm::service' do |facts|
  it do
    is_expected.to contain_service('opensm').with({
      :ensure       => 'running',
      :enable       => 'true',
      :name         => 'opensm',
      :hasstatus    => 'true',
      :hasrestart   => 'true',
    })
  end

  context 'ensure => absent' do
    let(:params) {{ :ensure => 'absent' }}
    it { is_expected.to contain_service('opensm').with_ensure('stopped').with_enable('false') }
  end
end
