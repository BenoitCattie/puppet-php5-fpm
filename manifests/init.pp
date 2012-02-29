# Class: php5-fpm
#
# This class manage php5-fpm installation and configuration.
# Config file 'php-fpm.conf' is very minimal
# only include /etc/php5/fpm/pool.d/*.conf
#
# Use php5-fpm::config for configuring php5-fpm
#
# Templates:
#    - php-fpm.conf.erb
#
class php5-fpm {

    package { 'php5-fpm': ensure => installed }

    service { 'php5-fpm':
        ensure      => running,
        hasstatus    => true,
        enable      => true,
        require     => File['/etc/php5/fpm/php-fpm.conf'],
        restart     => '/etc/init.d/php5-fpm reload',
    }

    file { '/etc/php5/fpm/php-fpm.conf':
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('php5-fpm/php-fpm.conf.erb'),
        require => Package['php5-fpm'],
    }
}
