pipeline{

    agent any
    
    environment {
        dockerImage = ''
        registry = 'sibidock24/tomcat-helloworld'
        registryCredential = 'docker-image1'
        
    }

    stages {

        stage('Checkout Source') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Avudayappan/test-servlet.git/']]])
            }
        }
        
        stage('Build WAR') {
            steps{
                sh gradlew build
            }
        }
        
        stage('Build docker image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        
        stage('Uploading image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }
        }
    }
    
    // Stopping Docker containers for cleaner Docker run
     stage('docker stop container') {
         steps {
            sh 'docker ps -f name=tomcat-helloworld -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=tomcat-helloworld -q | xargs -r docker container rm'
         }
       }
       
        // Running Docker container, make sure port 8096 is opened in 
    stage('Docker Run') {
     steps{
         script {
            dockerImage.run("-p 8096:8000 --rm --name tomcat-helloworld")
         }
     }
    } 
  }
}
