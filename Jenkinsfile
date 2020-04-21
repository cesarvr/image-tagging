// project/image_name:tag
def SRC_PROJECT  = {params.SRC_PROJECT} 
def SRC_IMAGE    = {params.SRC_IMAGE} 
def SRC_TAG      = {params.SRC_TAG} 

def DEST_PROJECT  = {params.DEST_PROJECT} 
def DEST_IMAGE    = {params.DEST_IMAGE} 
def DEST_TAG      = {params.DEST_TAG} 


def IMAGE = "${SRC_PROJECT}/${SRC_IMAGE}:${SRC_TAG}" 
def PROD_IMAGE   = "${DEST_PROJECT}/${DEST_IMAGE}:${DEST_TAG}" 

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
                echo "tagging : " + IMAGE
                sh "oc tag ${IMAGE} ${PROD_IMAGE}"
            }

            stage('Deploying Image') {
                echo "deploying: " + BUILD_TAG + " on " + DEST_PROJECT
                sh "oc project ${DEST_PROJECT}"
                sh "chmod +x build.sh"
                sh "./build.sh ${DEST_IMAGE}"
            }
            /* More stages */
        }
    }
}

