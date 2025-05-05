pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = 'snake-game-test'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/dslwa/snake-game.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Snake Game') {
            steps {
                echo "Running Snake Game container..."
                sh 'docker run --rm $IMAGE_NAME || true'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}