# Class: yumrepos::elasticsearch5
#
# Installs the Elasticsearch 1.6 yum repository.
#
class yumrepos::elasticsearch5 (
  $elasticsearch5_url = $yumrepos::params::elasticsearch5_url,
  $elasticsearch5_enabled = $yumrepos::params::elasticsearch5_enabled,
  $elasticsearch5_gpgcheck = $yumrepos::params::elasticsearch5_gpgcheck,
  $elasticsearch5_includepkgs = $yumrepos::params::elasticsearch5_includepkgs,
  $elasticsearch5_exclude = $yumrepos::params::elasticsearch5_exclude,
) inherits yumrepos::params {

  file { '/etc/pki/rpm-gpg/GPG-KEY-elasticsearch':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/yumrepos/etc/pki/rpm-gpg/GPG-KEY-elasticsearch',
  }

  yumrepo { 'elasticsearch5':
    descr       => 'Elasticsearch 5',
    baseurl     => $elasticsearch5_url,
    enabled     => $elasticsearch5_enabled,
    includepkgs => $elasticsearch5_includepkgs,
    exclude     => $elasticsearch5_exclude,
    gpgcheck    => $elasticsearch5_gpgcheck,
    gpgkey      => 'file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch',
    require     => File['/etc/pki/rpm-gpg/GPG-KEY-elasticsearch'],
  }
}
