pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'export; ls -la'
                sh 'eval $(docker-machine env luanginx)'
                sh 'docker build . -t darkkc/luanginx:latest'
                sh 'docker push darkkc/luanginx:latest'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'eval $(docker-machine env luanginx)'
                sh 'docker stop luanginx'
                sh 'docker rm luanginx'
                sh 'docker run --name luanginx -p 8000:80 darkkc/luanginx:latest'
            }
        }
    }
}