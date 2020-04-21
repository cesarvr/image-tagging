



def NODEJS_IMAGE = 'docker-registry.default.svc:5000/openshift/nodejs:10'
def NODEJS_CONTAINER_NAME = 'nodejs'

podTemplate(cloud:'openshift', label: BUILD_TAG,

  containers: [
      containerTemplate(name: NODEJS_CONTAINER_NAME, image: NODEJS_IMAGE,
       ttyEnabled: true,
       command: 'cat'),
  ] ) {

    node(BUILD_TAG) {

        container(NODEJS_CONTAINER_NAME) {
          // Running on NodeJS container...

          stage('Hello World') {
              echo "build: " + BUILD_TAG
              sh 'node -v'
          }
          /* More NodeJS related stages ... */

        }

    }
}