# Class: yumrepos::varnish41
#
# Installs the Varnish 4.1 yum repository.
#
class yumrepos::varnish41 (
  $varnish41_url = $yumrepos::params::varnish41_url,
  $varnish41_enabled = $yumrepos::params::varnish41_enabled,
  $varnish41_gpgcheck = $yumrepos::params::varnish41_gpgcheck,
  $varnish41_includepkgs = $yumrepos::params::varnish41_includepkgs,
  $varnish41_exclude = $yumrepos::params::varnish41_exclude,
) inherits yumrepos::params {

  if ! defined(File['/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH']) {
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH':
      ensure => present,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///modules/yumrepos/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
    }
  }

  yumrepo { 'varnish41':
    descr       => 'Varnish 4.1',
    baseurl     => $varnish41_url,
    enabled     => $varnish41_enabled,
    includepkgs => $varnish41_includepkgs,
    exclude     => $varnish41_exclude,
    gpgcheck    => $varnish41_gpgcheck,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH'],
  }
}
