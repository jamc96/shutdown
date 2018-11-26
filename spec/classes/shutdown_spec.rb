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
      if os_facts['operatingsystemrelease'] == '7'
        s_file = '/usr/lib/systemd/system/ctrl-alt-del.target'
      else
        s_file = '/etc/init/control-alt-delete.conf'
      end
      it { is_expected.to contain_file(s_file).with(ensure: 'present') } 
    end
  end
end
