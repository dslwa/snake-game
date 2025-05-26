pipeline {
  agent any
  environment {
    DOCKER_HOST        = 'tcp://dind:2375'
    DOCKER_TLS_CERTDIR = ''
  }
  stages {
    stage('Build deps image') {
      steps {
        dir('docker/dependencies') {
          sh 'docker build -t rafal206/dependencies:1.0 .'
        }
      }
    }

    stage('Compile & Test') {
      agent {
        docker {
          image 'rafal206/dependencies:1.0'
          args  '--privileged -u root -v /var/run/dockeSr.sock:/var/run/docker.sock'
        }
      }
    steps {

      sh 'mkdir -p output'
      sh 'make build > output/build.log 2>&1 || true'
      sh 'make test  > output/test.log  2>&1 || true'

      archiveArtifacts artifacts: 'output/build.log,output/test.log', fingerprint: true
    }
    }
  }

  post {
    always {
      echo "End of pipeline, artifacts and image available"
    }
  }
}
