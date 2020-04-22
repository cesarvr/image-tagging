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

In this example we are going to use Openshift ``oc tag`` command that give us a way to tag images and move *promote* images across projects. 

Syntax: 

```sh
oc tag <project>/<image>:<tag> <dest-project>/<new-name>:<tag>
```

Example: 

```sh
oc tag ctest/frontend:latest uat/frontend:stable
```
> This will tag and copy the latest ``frontend`` image version into a new project changing the tag to ``stable``.  






### Jenkins DSL 

Here is a quick DSL example that tags an arbitrary image and deploys it into a specified namespace.

To run this pipeline script: 

```sh
oc new-build https://github.com/cesarvr/image-tagging.git --strategy=pipeline --name=build-img-tag
```


### Params

This pipeline scripts require this parameters to work:

```sh
oc set env bc/build-img-tag IMAGE=frontend \
		SRC_PROJECT=development \
		SRC_TAG=latest \
		DEST_PROJECT=uat \
		DEST_TAG=uat 
```

``IMAGE`` represents the image name. 
``SRC_PROJECT`` the project/namespace where this image is stored. 
``SRC_TAG`` current tag of this image. 
``DEST_PROJECT`` project we want to copy this image.
``DEST_TAG`` the new tag we want to specify.


### Adding Roles 

To promote this image, Jenkins service accounts need to be granted permissions to move images and create objects between namespaces.

```sh
oc adm policy add-role-to-user admin system:serviceaccount:ctest:jenkins -n uat
oc adm policy add-role-to-user admin system:serviceaccount:ctest:jenkins -n development
```

> These permissions are local to Jenkins process. 


