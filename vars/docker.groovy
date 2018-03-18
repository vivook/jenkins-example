def compose(String params) {
    def cmd = "/usr/local/bin/docker-compose -p ${env.BUILD_ID} -f docker/docker-compose.yml"
    sh "$cmd $params"
}