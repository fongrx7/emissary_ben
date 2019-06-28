pipeline {
    agent none
    stages {
        stage('Build') {
	    agent any
	    tools {
    	    	  maven 'Maven 3.6.1'
   	    }
            steps {
	        sh 'yum update -y'
		sh 'yum install -y java-1.8.0-openjdk unzip wget tar which expect perl'
		sh 'cat bashrc_addition >> /root/.bashrc'
		sh 'mkdir -p ~/.m2'
		sh 'chmod -R 777 ~/.m2'
		sh 'rm -rf ~/.m2/repository'
		sh 'mv settings.xml ~/.m2'
		sh 'mv settings-security.xml ~/.m2'
		sh 'cat /root/.bashrc'

		sh 'expect -version'
		
		sh 'echo $JAVA_HOME'
		sh 'java -version'
		sh 'mvn -v'
		sh 'mvn clean install'
		sh 'mvn test'
		sh 'mvn clean package -Pdist -e -X'
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