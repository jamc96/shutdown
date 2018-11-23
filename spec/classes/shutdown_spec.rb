require 'spec_helper'

describe 'shutdown' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      # compilation checking
      it { is_expected.to compile }
      it { is_expected.to compile.with_all_deps }
      # class relationship
      it { is_expected.to contain_class('shutdown::config') }
      # validate resources
      it { is_expected.to contain_file('/etc/init/control-alt-delete.conf').with(ensure: 'present') } 
    end
  end
end
