#!/bin/bash
LATEAST_TAG="rtsundland/ntpd:latest"
BUILD_TAG="rtsundland/ntpd:$1"

docker build . --pull --rm -t ${LATEST_TAG} -t ${BUILD_TAG} && \
	docker push ${LATEST_TAG}
