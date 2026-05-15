pipeline {
  environment {
    frontendImageName = "asma2024/crud-frontend"
    frontendImageTag = "${BUILD_NUMBER}"
  }

  agent any

  stages {
    stage('Checkout SCM') {
      steps {
        git branch: 'main', url: 'https://github.com/asma2024/crud-users-tutorial.git'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm install'
      }
    }

    stage('Unit Tests') {
      steps {
        script {
            sh 'node -v'
            echo "Tests unitaires simulés avec succès"
        }
      }
    }

    stage('Docker Build') {
      steps {
        script {
          sh "docker build -t ${frontendImageName}:${frontendImageTag} ."
        }
      }
    }

    stage('Cleanup') {
      steps {
        sh "docker rmi ${frontendImageName}:${frontendImageTag}"
      }
    }
  }
  
  post {
    success {
      echo "Le build de test a réussi !"
    }
    failure {
      echo "Le build a échoué. Vérifiez les logs Jenkins."
    }
  }
}
