pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'docker build . -t darkkc/luanginx:latest'
                sh 'docker push darkkc/luanginx:latest'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'eval $(docker-machine env luanginx); \
                 docker pull darkkc/luanginx:latest; \
                 docker stop luanginx; \
                 docker rm luanginx; \
                 docker run -d --name luanginx -p 8000:80 darkkc/luanginx:latest'
            }
        }
    }
}