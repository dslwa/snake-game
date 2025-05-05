pipeline {
    agent any

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
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Game') {
            steps {
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
