pipeline {
    // checkout the code

    // build 2 containers in parallel, failing fast

    // run tests in parallel

    // push them to docker hub in parallel

    // deploy them both locally using docker compose

    // confirm they're both live

    // wait for an input to stop one or both of them

    agent any

    options {
        skipStagesAfterUnstable()
        timeout(time: 1, unit: 'HOURS')
    }

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
                // todo - push specific tags (e.g. $env.BUILD_ID) and in parallel
//                script {
//                    docker.withRegistry("https://index.docker.io/v1/", "vivook-dockerhub") {
//                        sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml push"
//                    }
//                }
                echo "Uncomment the above (when more bandwidth is available)"
            }
        }

        stage('Deploy to staging') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                // to do: Pass an extra file to docker-compose with staging settings in
                sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml up -d"
            }
        }

        stage('Deploy to prod') {
            when {
                branch 'master'
            }
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input(message: "Deploy to prod?", ok: "Yes")
                }

                sh "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml up -d"
            }
        }

        stage('Functional tests') {
            steps {
                echo "To do: Run tests in parallel to make sure services came up correctly"
            }
        }
    }
    post {
        success {
            echo "Pipeline completed successfully"
        }
        failure {
            mail(subject: "Pipeline failed",
                    body: "Build ${env.BUILD_ID} of job ${env.JOB_NAME} failed. For details see ${currentBuild.absoluteUrl}.",
                    to: env.BUILD_URL)
        }
        unstable {
            mail(subject: "Pipeline returned an 'unstable' status",
                    body: "Build ${env.BUILD_ID} of job ${env.JOB_NAME} failed. For details see ${currentBuild.absoluteUrl}.",
                    to: env.BUILD_URL)
        }
    }
}