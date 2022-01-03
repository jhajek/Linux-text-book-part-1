// https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                  echo 'Building..'
                  sh 'chmod +x ./build-linux-and-macos.sh'
                  sh './build-linux-and-macos.sh'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying....'
                    sh '/opt/github-push-scripts/linux-textbook-release-script.sh'
                }
                
            }
        }
    }
}