def SRC_IMAGE  = {params.IMAGE} // project/image_name
def DEST_IMAGE  = {params.IMAGE} // project/image_name

def JENKINS_SLAVE_IMAGE = "registry.redhat.io/openshift3/jenkins-slave-base-rhel7:v3.11"
def JNLP = 'jnlp'

podTemplate(cloud:'openshift', 
    label: BUILD_TAG, 
    containers: [
    containerTemplate(
        name: JNLP, 
        image: JENKINS_SLAVE_IMAGE),
  ]) {
    node(BUILD_TAG) {
        container(JNLP) {
            stage('Hello') {
                echo "build: " + BUILD_TAG
                sh "chmod +x ../script/build/deploy.sh"
                sh ". ../script/build/deploy.sh ${SRC_IMAGE}"
            }
            /* More stages */
        }
    }
}

