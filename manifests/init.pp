# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include shutdown
class shutdown(
  Boolean $enable                         = true,
  Optional[String] $config_path           = undef,
  Enum['present','absent'] $config_ensure = 'present',
  Optional[String] $config_template       = undef
) {
  # set variables
  $status = bool2str($enable,'enable','disable')
  # validate variables
  if $facts['os']['family'] == 'RedHat' {
    $config_path_flg = $facts['operatingsystemmajrelease'] ? {
      '7'     => '/usr/lib/systemd/system/ctrl-alt-del.target',
      default => '/etc/init/control-alt-delete.conf',
    }
  }else {
    $config_path_flg = $config_path
  }
  $config_template_flg = $config_template ? {
    undef => { content => template("${module_name}/rhel-${::operatingsystemmajrelease}-${status}.erb") },
    default => { source => $config_template },
  }
  # add class config
  include ::shutdown::config
}
