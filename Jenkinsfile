pipeline {
    // checkout the code

    // build 2 containers in parallel, failing fast

    // run tests in parallel

    // push them to docker hub in parallel

    // deploy them both locally using docker compose

    // confirm they're both live

    // wait for an input to stop one or both of them

    agent any

    stages {
        stage('Build') {
            failFast true

            parallel {
                stage('Build app1') {
                    steps {
                        echo "Building app1"
                        // we could extract the output of docker-compose --build to avoid having to specify `vivook/app1:latest` here
                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml up --build --no-start app1"
                        // this will tag the image as `${env.BUILD_ID}_app1:latest`, so retag it with the build ID
                        sh "/usr/bin/docker tag vivook/app1:latest vivook/app1:${env.BUILD_ID}"
                    }
                }
                stage('Build app2') {
                    steps {
                        echo "Building app2"
                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml up --build --no-start app2"
                        // this will tag the image as `${env.BUILD_ID}_app2:latest`, so retag it with the build ID
                        sh "/usr/bin/docker tag vivook/app2:latest vivook/app2:${env.BUILD_ID}"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                echo "To do: Run tests in parallel here using `docker-compose run`..."
            }
        }

        stage('Push') {
            steps {
                // todo - in parallel
                script {
                    docker.withRegistry("https://registry.hub.docker.com", "vivook-dockerhub") {
                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml push"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml up -d"
            }
        }

        stage('Functional tests') {
            steps {
                echo "To do: Run tests in parallel here..."
            }
        }


    }
}