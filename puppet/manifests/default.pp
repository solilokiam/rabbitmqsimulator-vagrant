Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


class system-update {

    exec { 'apt-get update':
        command => 'apt-get update',
    }
}

class { 'nodejs':
  version => 'stable',
}

class dev-packages {
    include wget
    include nodejs

    $devPackages = [ "vim", "git","build-essential" ]
    package { $devPackages:
        ensure => "installed",
        require => Exec['apt-get update'],
    }
}

class rabbitsimulator {
    require dev-packages
    require nodejs
    
    exec { 'git clone https://github.com/RabbitMQSimulator/RabbitMQSimulator.git':
    	command => 'git clone https://github.com/RabbitMQSimulator/RabbitMQSimulator.git /var/simulator'
    }

    exec { 'npm install':
    	command => 'npm install',
    	cwd => '/var/simulator'
    }

    exec { 'node app.js':
        command => 'node app.js',
        cwd => '/var/simulator',

    }
}



include system-update
include dev-packages
include rabbitsimulator
