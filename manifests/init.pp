class crucible (
  String $version = '4.0.3',
  Boolean $service_manage = true,
  String $service_ensure = 'running',
  Boolean $service_enable = true,
  String $service_name = 'crucible',
  String $service_user = 'crucible',
  Boolean $install_java = true,
  $java_home = undef,
  $java_opts = undef,
  Stdlib::Absolutepath $install_dir = '/opt/crucible',
  Stdlib::Absolutepath $home_dir = undef,
  Stdlib::Absolutepath $fisheye_inst = '/opt/crucible-data',
  Boolean $install_unzip = true,
  Boolean $install_wget = true,
  Stdlib::HTTPUrl $download_url = 'https://www.atlassian.com/software/crucible/downloads/binary',
  Boolean $user_manage = true,
  $internet_proxy = undef,
) {

  if $home_dir {
    $homedir = $home_dir
  } else {
    $homedir = "/home/${service_user}"
  }

  assert_type(Pattern[/^.*\.*\.*$/], $version)
  assert_type(Stdlib::Absolutepath, $homedir)

  class { '::crucible::install': }
  -> class { '::crucible::config': }
  ~> class { '::crucible::service': }

}
