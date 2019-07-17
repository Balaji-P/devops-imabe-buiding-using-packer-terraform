#!/bin/bash

# Get the latest Ubuntu 1804 image id from gcloud
export UBUNTU_IMAGE=$(gcloud compute images describe-from-family ubuntu-1804-lts --project=ubuntu-os-cloud --format 'value(name)')

# Run packer build with user variables from env
packer build \
-var zone=$ZONE \
-var project_id=$PROJECT_ID \
-var source_image=$UBUNTU_IMAGE \
-var image_name=$IMAGE_ID \
packer/packer.json
