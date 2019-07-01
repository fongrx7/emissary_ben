pipeline {
    agent none
    stages {
        stage('Build Emissary') {
	    agent any
	    tools {
    	    	  maven 'Maven 3.6.1'
   	    }
            steps {
	        sh 'sudo yum update -y'
		sh 'sudo yum install -y java-1.8.0-openjdk unzip wget tar which expect perl docker docker-compose'
		sh 'cat bashrc_addition >> ~/.bashrc'
		sh 'mkdir -p ~/.m2'
		sh 'chmod -R 777 ~/.m2'
		sh 'rm -rf ~/.m2/repository'
		sh 'mv settings.xml ~/.m2'
		sh 'mv settings-security.xml ~/.m2'
		sh 'cat ~/.bashrc'

		sh 'expect -version'
		
		sh 'echo $JAVA_HOME'
		sh 'java -version'
		sh 'mvn -v'
		sh 'mvn clean install'
            }
        }
	stage('Build Docker Image'){
	    agent any
	    tools {
    	    	  maven 'Maven 3.6.1'
   	    }
	    steps {
	        sh 'sudo systemctl start docker'
		sh 'mvn clean package -Pdist'
	   	sh 'sudo docker build -t emissary:latest --build-arg PROJ_VERS=$(./emissary version | grep Version: | awk {"print $3 " " "}) --build-arg IMG_NAME=latest .'
	    }
	}
        stage('Test') {
	    agent any
            steps {
                sh 'mvn test' 
		sh './test_script.sh'	
            }
        }
    }
}