pipeline {
    agent any


    environment {
        APP_NAME = "my-java-app"
        IMAGE_NAME = "adeola1976/jenkins"
        TAG = "${env.BUILD_NUMBER}"
        SONAR_URL = "http://localhost:2000"
    }
    stages {
        stage('Static Code Analysis') {
           steps {
              withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
              bat 'mvn sonar:sonar -Dsonar.login=%SONAR_AUTH_TOKEN% -Dsonar.host.url=http://localhost:2000'
            }
          }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }

        // OPTIONAL: Push to Docker Hub
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials-id') {
                        docker.image("${IMAGE_NAME}:${TAG}").push()
                        docker.image("${IMAGE_NAME}:${TAG}").push('latest')
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Image built: ${IMAGE_NAME}:${TAG}"
        }
        failure {
            echo "Build failed"
        }
    }
}