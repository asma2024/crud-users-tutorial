pipeline {
  environment {
    backendImageName = "asma2024/crud-backend"
    backendImageTag = "${BUILD_NUMBER}"
    REGISTRY_CRED = "docker-hub-credentials"
    SONAR_SERVER = "SonarQube"
  }

  agent any

  stages {
    stage('Checkout SCM') {
      steps {
        git branch: 'backend', url: 'https://github.com/asma2024/crud-users-tutorial.git'
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

    stage('Analyse Code - SonarQube') {
      steps {
        withSonarQubeEnv("${SONAR_SERVER}") {
          sh 'npx sonar-scanner -Dsonar.projectKey=crud-backend -Dsonar.sources=.'
        }
      }
    }

    stage('Docker Build') {
      steps {
        script {
          sh "docker build -t ${backendImageName}:${backendImageTag} ."
          sh "docker build -t ${backendImageName}:latest ."
        }
      }
    }

    stage('Sécurité Image - Trivy') {
      steps {
        sh "trivy image --severity HIGH,CRITICAL ${backendImageName}:${backendImageTag}"
      }
    }

    stage('Push Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${REGISTRY_CRED}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
          sh "docker push ${backendImageName}:${backendImageTag}"
          sh "docker push ${backendImageName}:latest"
        }
      }
    }

    stage('Cleanup') {
      steps {
        sh "docker rmi ${backendImageName}:${backendImageTag} || true"
        sh "docker rmi ${backendImageName}:latest || true"
      }
    }
  }

  post {
    success {
      echo "Le build de test du backend a réussi !"
    }
    failure {
      echo "Le build du backend a échoué. Vérifiez les logs Jenkins."
    }
  }
}