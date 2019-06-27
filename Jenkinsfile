 pipeline {
    agent none
    stages {
        stage('Build') {
	    agent any
	    tools {
    	    	  maven 'Maven 3.6.1'
	  	  jdk 'jdk8'
   	    }
            steps {
		sh 'mkdir -p /var/jenkins_home/test_runner_home'
		sh 'deluser test_runner 2>/dev/null'
		sh 'id -u test_runner || adduser --disabled-password --home /var/jenkins_home/test_runner_home --gecos "" test_runner'		

	        sh 'apt-get -y update'
		sh 'apt-get -y install unzip wget tar perl sudo'

		sh 'cat bashrc_addition >> /var/jenkins_home/test_runner_home/.bashrc'
		sh 'rm -rf /var/jenkins_home/test_runner_home/.m2'
		sh 'mkdir -p /var/jenkins_home/test_runner_home/.m2'
		sh 'chmod -R 777 /var/jenkins_home/test_runner_home/.m2'
		sh 'rm -rf /var/jenkins_home/test_runner_home/.m2/repository'
		sh 'mv settings.xml /var/jenkins_home/test_runner_home/.m2'
		sh 'mv settings-security.xml /var/jenkins_home/test_runner_home/.m2'
		sh 'cat /var/jenkins_home/test_runner_home/.bashrc'
		sh 'chown -R test_runner:test_runner /var/jenkins_home/test_runner_home'		
		sh 'chmod -R 777 /var/jenkins_home/test_runner_home'		
		
		sh 'mkdir -p /var/jenkins_home/test_runner_home/installs'
		sh 'cd /var/jenkins_home/test_runner_home/installs && curl -o expect.deb http://ftp.us.debian.org/debian/pool/main/e/expect/expect_5.45-6_amd64.deb && apt install -y ./expect.deb'
		sh 'chmod -R 777 /var/jenkins_home/test_runner_home/installs'
		sh 'expect -version'

		sh 'chmod -R a+rw /var/jenkins_home/workspace/emissary'
		sh 'chown -R test_runner:test_runner /var/jenkins_home/workspace/emissary'
		sh 'chmod -R 777 /var/jenkings_home/tools/'

		sh 'runuser -l test_runner -c "source /var/jenkins_home/test_runner_home/.bashrc && cd /var/jenkins_home/workspace/emissary && export JAVA_HOME=/var/jenkins_home/tools/hudson.model.JDK/jdk8 && $(which mvn) clean compile"'
		sh 'runuser -l test_runner -c "source /var/jenkins_home/test_runner_home/.bashrc && cd /var/jenkins_home/workspace/emissary && export JAVA_HOME=/var/jenkins_home/tools/hudson.model.JDK/jdk8 && $(which mvn) clean package -Pdist -e"'
            }
        }
        stage('Test') {
	    agent {
            	  docker {
            	  	 image 'centos:7'
        	  }
    	    }
            steps {
                sh 'mvn test -e' 
            }
            post {
                always {
                    sh './test_script.sh'
                }
            }
        }
    }
}



