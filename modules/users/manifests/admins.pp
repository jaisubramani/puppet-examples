class users::admins {
  user { 'admin':
    ensure => present,
    gid    => 'staff',
    shell  => '/bin/bash',
  }
  group { 'staff':
    ensure => present,
  }
}
