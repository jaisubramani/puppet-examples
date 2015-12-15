# to run: cd /vagrant && sudo puppet apply -e "include nginx" --modulepath=/vagrant/modules
class nginx (
  $availability_zone,
  $dns_servers = [],
  $log_level = 'error',
){
  package { 'nginx':
    ensure => present,
  }

  file { '/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  file { '/var/www/index.html':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }

  file { '/usr/share/nginx/html/index.html':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template('nginx/stat.html.erb'),
  }

  service { 'nginx':
    ensure => running,
  }
}
