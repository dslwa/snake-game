pipeline {
    agent any

    environment {
        WORKDIR = 'GR3/DS415335/Lab03'
        OUTPUT_DIR = 'output'
    }

    stages {
        stage('Start Trigger') {
            steps {
                echo "Rozpoczęcie pipeline – Build #${env.BUILD_NUMBER}"
            }
        }

        stage('Prepare Environment') {
            steps {
                sh '''
                    apt-get update
                    apt-get install -y git make golang
                '''
            }
        }

        stage('Build') {
            steps {
                dir("${WORKDIR}") {
                    sh '''
                        mkdir -p ${OUTPUT_DIR}
                        echo "=== BUILD START ===" > ${OUTPUT_DIR}/build_log.log
                        make build >> ${OUTPUT_DIR}/build_log.log 2>&1 || echo "Błąd w buildzie!"
                        echo "=== BUILD END ===" >> ${OUTPUT_DIR}/build_log.log
                        cat ${OUTPUT_DIR}/build_log.log
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                dir("${WORKDIR}") {
                    sh '''
                        echo "=== TEST START ===" > ${OUTPUT_DIR}/test_log.log
                        make test >> ${OUTPUT_DIR}/test_log.log 2>&1 || echo "Błąd w testach!"
                        echo "=== TEST END ===" >> ${OUTPUT_DIR}/test_log.log
                        cat ${OUTPUT_DIR}/test_log.log
                    '''
                }
            }
        }

        stage('Archive Logs') {
            steps {
                dir("${WORKDIR}") {
                    archiveArtifacts artifacts: "${OUTPUT_DIR}/*.log", fingerprint: true
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline zakończony – logi dostępne jako artefakty."
        }
        cleanup {
            dir("${WORKDIR}") {
                sh "rm -rf ${OUTPUT_DIR} || true"
            }
        }
    }
}
