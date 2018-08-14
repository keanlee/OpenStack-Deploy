#!/bin/bash
IMAGE_ID=7d45bf74-5050-4932-946d-9c067286f394
FLAVOR_ID=af7a0a49-2354-4885-912e-53513ba2913e
NET_ID=c953d02c-1e4f-4f8a-ac82-28a667d54235
VM_NAME=TEST
COMPUTE_HOST_NAME=HermesStack-Node6-Compute-3


nova boot --image ${IMAGE_ID} --flavor ${FLAVOR_ID} --nic net-id=${NET_ID} ${VM_NAME} \
--availability-zone nova:${COMPUTE_HOST_NAME}
