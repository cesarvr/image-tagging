## Openshift Tag

We can consider image tags as additional image metadata that provide additional information about a specific image. 

A common example is when we use tags to inform about the version of  an image:

```sh
rhel:6
rhel:7
…
nodejs:8
nodejs:latest
```

We can also use tags to separate images from the current update stream:

```sh 
frontend:dev
frontend:unstable
frontend:nightly 
```

In this example we are going to use **Openshift** ``oc tag`` command to **tag images** and move or **promote** images across projects. 

Syntax: 

```sh
oc tag <project>/<image>:<tag> <dest-project>/<new-name>:<tag>
```

Example: 

```sh
oc tag ctest/frontend:latest uat/frontend:stable
```

We can verify this:

```sh
oc project uat # Change to project UAT 

oc get is      # List all images on UAT

# NAME       DOCKER REPO                                     TAGS      ...
# frontend   docker-registry.default.svc:5000/uat/frontend   stable    ...
```

### Jenkins DSL 

Here is a quick DSL example that tags an arbitrary image and deploys it into a specified namespace.

To run this pipeline script: 

```sh
oc new-build https://github.com/cesarvr/image-tagging.git --strategy=pipeline --name=build-img-tag
```

> I created [this build script](https://github.com/cesarvr/image-tagging/blob/master/build.sh) to create a *generic* deployment.


### Params

To work pipeline scripts require the following parameters:

```sh
oc set env bc/build-img-tag IMAGE=frontend \
		SRC_PROJECT=development \
		SRC_TAG=latest \
		DEST_PROJECT=uat \
		DEST_TAG=uat 
```

- ``IMAGE`` represents the image name. 
- ``SRC_PROJECT`` the project/namespace where this image is stored. 
- ``SRC_TAG`` current tag of this image. 
- ``DEST_PROJECT`` project we want to copy this image.
- ``DEST_TAG`` the new tag we want to specify.


### Adding Roles 

To promote this image, Jenkins service accounts need to be granted permissions to move images and create objects between namespaces.

To provided those permissions we can use: 

```sh
oc adm policy add-role-to-user admin system:serviceaccount:ctest:jenkins -n uat
oc adm policy add-role-to-user admin system:serviceaccount:ctest:jenkins -n development
```

> These will grant permissions to Jenkins to operate in the ``uat`` and ``development`` project. 


The pipeline should look like this: 

![](https://github.com/cesarvr/image-tagging/blob/master/img/tagging.gif?raw=true)

