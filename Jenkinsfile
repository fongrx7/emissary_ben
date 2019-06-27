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
	    	sh 'uname'
		
	        sh 'apt-get -y update'
		sh 'apt-get -y install unzip wget tar perl'
		sh 'cat bashrc_addition >> /root/.bashrc'
		sh 'mkdir -p ~/.m2'
		sh 'chmod -R 777 ~/.m2'
		sh 'rm -rf ~/.m2/repository'
		sh 'mv settings.xml ~/.m2'
		sh 'mv settings-security.xml ~/.m2'
		sh 'cat /root/.bashrc'
		sh 'grep -h ^deb /etc/apt/sources.list'

		sh 'cd /tmp && curl -o expect.deb http://ftp.us.debian.org/debian/pool/main/e/expect/expect_5.45-6_amd64.deb && apt install -y ./expect.deb'
		sh 'expect -version'
		
		sh 'echo $JAVA_HOME'
		sh 'java -version'
		sh 'mvn -v'
		sh 'mvn clean install'
		sh 'mvn clean package -Pdist -e'
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