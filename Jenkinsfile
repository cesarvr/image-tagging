
// project/image_name:tag
def FULL_IMAGE_NAME = "${SRC_PROJECT}/${IMAGE}:${SRC_TAG}" 
def TAGGED_IMAGE    = "${DEST_PROJECT}/${IMAGE}:${DEST_TAG}" 

def BUILD_SCRIPT = "https://raw.githubusercontent.com/cesarvr/image-tagging/master/build.sh"
def JENKINS_SLAVE_IMAGE = "registry.redhat.io/openshift3/jenkins-slave-base-rhel7:v3.11"
def JNLP = 'jnlp'

podTemplate(cloud:'openshift', 
    label: BUILD_TAG, 
    serviceAccount: 'jenkins',
    containers: [
        containerTemplate(
            name: JNLP, 
            image: JENKINS_SLAVE_IMAGE  
        )
    ]
) {
    node(BUILD_TAG) {
        container(JNLP) {
            stage('Tagging Image') {
                
                sh "oc tag ${FULL_IMAGE_NAME} ${TAGGED_IMAGE}"
            }

            /*
            stage('Deploying Storage, DBs, Other Dependencies ') {
            
            }
            */
            
            stage('Deploying Image') {
                echo " Deploying: ${FULL_IMAGE_NAME} on ${DEST_PROJECT}" 
                sh "oc project ${DEST_PROJECT}"
                sh "curl -s ${BUILD_SCRIPT} | bash /dev/stdin ${IMAGE}" 

                sh "oc rollout latest dc/${IMAGE}" 
            }
            /* More stages */
        }
    }
}

