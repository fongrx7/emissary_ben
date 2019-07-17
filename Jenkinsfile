pipeline {
    agent any
    tools {
        maven 'Maven 3.6.1'
    }
    stages {
        stage('Build Emissary') {
            steps {
		sh 'sudo yum install -y java-1.8.0-openjdk-devel java-1.8.0-openjdk tar expect which docker docker-compose'
		sh 'cat src/test/resources/jenkins_config/bashrc_addition >> ~/.bashrc'
		sh 'mkdir -p ~/.m2'
		sh 'sudo chown -R $(whoami):$(whoami) $(pwd)'
		sh 'rm -rf ~/.m2/repository'
		sh 'mv src/test/resources/jenkins_config/settings.xml ~/.m2'
		sh 'mv src/test/resources/jenkins_config/settings-security.xml ~/.m2'
		sh 'mvn clean install'
		sh 'mvn clean compile'
            }
        }
	stage('Build Docker Image'){
	    steps {
	        sh 'sudo systemctl start docker'
		sh 'mvn clean package -Pdist'
	   	sh 'docker build -t emissary:latest --build-arg PROJ_VERS=$(./emissary version | grep Version: | awk {\'print $3 " " \'}) --build-arg IMG_NAME=latest .'
		sh 'sudo docker build -f Dockerfile-test_feeder -t emissary-feeder-test:latest --build-arg PROJ_VERS=$(./emissary version | grep Version: | awk {'print $3 " " '}) --build-arg IMG_NAME=latest .'
	    }
	}
        stage('Test') {
            steps {
		sh 'rm -f test_results'
		sh 'sudo ./Docker_compose_test_script.sh'
            }
        }
    }
}