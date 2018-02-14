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
                sh 'eval $(docker-machine env luanginx); \
                 docker stop luanginx; \
                 docker rm luanginx; \
                 docker run -d --name luanginx -p 8000:80 darkkc/luanginx:latest'
            }
        }
    }
}