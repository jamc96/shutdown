# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include shutdown::config
class shutdown::config inherits shutdown {
  # set shutdown file configurations
  file { $shutdown::config_path_flg:
    ensure => $shutdown::config_ensure,
    owner  => 'root',
    group  => 'root',
    *      => $shutdown::config_template_flg,
  }
}
