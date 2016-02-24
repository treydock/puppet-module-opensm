shared_examples 'opensm::install' do |facts|
  it do
    is_expected.to contain_package('opensm').with({
      :ensure     => 'present',
      :name       => 'opensm',
      :notify     => 'Service[opensm]',
    })
  end

  context 'package_ensure defined' do
    let(:params) {{ :package_ensure => '3.3.17-1.el6' }}
    it { is_expected.to contain_package('opensm').with_ensure('3.3.17-1.el6') }
  end

  context 'ensure => absent' do
    let(:params) {{ :ensure => 'absent' }}
    it { is_expected.to contain_package('opensm').with_ensure('absent') }
  end
end
