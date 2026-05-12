pipeline {
    agent any

    environment {
        APP_NAME = "my-java-app"
        IMAGE_NAME = "Adeola1976/jenkins"
        TAG = "${env.BUILD_NUMBER}"
    }

    stages {

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