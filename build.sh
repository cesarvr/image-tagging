#!/bin/bash

oc create dc $1 --image=$(oc get is $1 -o=jsonpath='{.status.dockerImageRepository}'):prod || true &&
oc expose dc $1 --port=8080 -l app=$1 || true && 
oc expose svc $1 -l app=$1 || true &&
oc label dc $1 app=$1 production=true --overwrite=true || true
oc label svc $1 app=$1 production=true --overwrite=true || true
oc label route $1 app=$1 production=true --overwrite=true || true

