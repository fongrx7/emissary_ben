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
		sh 'apt-get -y install unzip wget tar perl'
		sh 'cat bashrc_addition >> /root/.bashrc'
		sh 'mkdir -p ~/.m2'
		sh 'chmod -R 777 ~/.m2'
		sh 'rm -rf ~/.m2/repository'
		sh 'mv settings.xml ~/.m2'
		sh 'mv settings-security.xml ~/.m2'
		sh 'cat /root/.bashrc'
		sh 'grep -h ^deb /etc/apt/sources.list'
		sh 'expect -version'
		
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



