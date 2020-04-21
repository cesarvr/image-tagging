// project/image_name:tag
def SRC_PROJECT  = {params.SRC_PROJECT} 
def IMAGE        = {params.IMAGE} 
def SRC_TAG      = {params.SRC_TAG} 

def DEST_PROJECT  = {params.DEST_PROJECT} 
def DEST_TAG      = {params.DEST_TAG} 


def FULL_IMAGE_NAME = "${SRC_PROJECT}/${IMAGE}:${SRC_TAG}" 
def TAGGED_IMAGE   = "${DEST_PROJECT}/${IMAGE}:${DEST_TAG}" 

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
            stage('Tagging Image') {
                echo "tagging:  ${FULL_IMAGE_NAME}" 
                //sh "oc tag ${FULL_IMAGE_NAME} ${TAGGED_IMAGE}"
            }

           /*  stage('Deploying Image') {
               echo "deploying: "+ ${FULL_IMAGE_NAME} on ${DEST_PROJECT}" 
                sh "o   c project ${DEST_PROJECT}"
                sh "chmod +x build.sh"
                sh "./build.sh ${IMAGE}" 
            }*/
            /* More stages */
        }
    }
}

