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
                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} up --build --no-start app1"
                        // this will tag the image as `${env.BUILD_ID}_app1:latest`
                    }
                }
                stage('Build app2') {
                    steps {
                        echo "Building app2"
                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} up --build --no-start app2"
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
                sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} push"
            }
        }

        stage('Deploy') {
            steps {
                sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} up -d"
            }
        }

        stage('Functional tests') {
            steps {
                echo "To do: Run tests in parallel here..."
            }
        }


    }
}