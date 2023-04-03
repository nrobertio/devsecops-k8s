pipeline {
  agent any

    stage('Docker Build and Push') {
      steps {
        withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
          sh 'printenv'
          sh 'docker build -t roni580/test:""$GIT_COMMIT"" .'
          sh 'docker push roni580/test:""$GIT_COMMIT""'
        }
      }
    }
  }
