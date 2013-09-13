Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


class system-update {

    exec { 'apt-get update':
        command => 'apt-get update',
    }
}

class dev-packages {
    include wget
    include nodejs

    $devPackages = [ "vim", "git","build-essentials" ]
    package { $devPackages:
        ensure => "installed",
        require => Exec['apt-get update'],
    }
}

class rabbitsimulator {
    require dev-packages
    exec { 'git clone https://github.com/RabbitMQSimulator/RabbitMQSimulator.git':
	command => 'git clone https://github.com/RabbitMQSimulator/RabbitMQSimulator.git /var/simulator'
    }

    exec { 'npm install':
	command => 'npm install',
	cwd => '/var/simulator'
    }
}

include system-update
include dev-packages
include rabbitsimulator
