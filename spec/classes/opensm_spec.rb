require 'spec_helper'

describe 'opensm' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to create_class('opensm') }
      it { is_expected.to contain_class('opensm::params') }
      it { is_expected.to contain_class('opensm::install').that_comes_before('Class[opensm::config]') }
      it { is_expected.to contain_class('opensm::config').that_comes_before('Class[opensm::service]') }
      it { is_expected.to contain_class('opensm::service') }

      it_behaves_like 'opensm::install', facts
      it_behaves_like 'opensm::config', facts
      it_behaves_like 'opensm::service', facts

      context 'when ensure => absent' do
        let(:params) {{ :ensure => 'absent' }}

        it { is_expected.to contain_class('opensm::service').that_comes_before('Class[opensm::config]') }
        it { is_expected.to contain_class('opensm::config').that_comes_before('Class[opensm::install]') }
        it { is_expected.to contain_class('opensm::install') }
      end

      context 'when priority => 16' do
        let(:params) {{ :priority => '16' }}

        it do
          expect {
            is_expected.to compile
          }.to raise_error
        end
      end

    end # end context
  end # end on_supported_os
end # end describe
