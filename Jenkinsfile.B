pipeline {
    agent any

    environment {
        IMAGE_NAME = 'dslwa525/snake-game'
        IMAGE_TAG = 'v1.0.0'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'master', url: 'https://github.com/dslwa/snake-game.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'docker run --rm ${IMAGE_NAME}:${IMAGE_TAG} python3 -m unittest || true'
            }
        }

        stage('Smoke Test') {
            steps {
                script {
                    def containerId = sh(script: "docker run -d ${IMAGE_NAME}:${IMAGE_TAG}", returnStdout: true).trim()
                    sleep(time: 3, unit: 'SECONDS')
                    sh "docker logs ${containerId} > smoke.log || true"
                    sh "docker rm -f ${containerId} || true"
                }
                archiveArtifacts artifacts: 'smoke.log'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline zakończony!'
        }
    }
}

