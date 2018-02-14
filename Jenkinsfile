pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'docker build .'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'docker stop luanginx'
                sh 'docker rm luanginx'
                sh 'docker run --name luanginx -p 8000:80 darkkc/luanginx:latest'
            }
        }
    }
}