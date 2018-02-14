pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                docker build .
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                docker stop luanginx
                docker rm luanginx
                docker run --name luanginx -p 8000:80 darkkc/luanginx:latest
            }
        }
    }
}