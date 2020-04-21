
### Install

```sh
oc new-build https://github.com/cesarvr/image-tagging.git --strategy=pipeline --name=build-img-tag
```


### Params

```sh
oc set env bc/build-img-tag SRC_IMAGE=front3nd SRC_PROJECT=ctest SRC_TAG=latest DEST_PROJECT=pro DEST_IMAGE=front3nd DEST_TAG=prod

```