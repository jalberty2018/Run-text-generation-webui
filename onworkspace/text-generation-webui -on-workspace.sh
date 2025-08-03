#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/text-generation-webui  ]]; then
	# If we don't already have /workspace/text-generation-webui , move it there
	mv /text-generation-webui  /workspace
	# Set permissions right for directory
    chmod -R 777 /workspace/text-generation-webui /user
else
	# otherwise delete the default text-generation-webui  folder which is always re-created on pod start from the Docker
	rm -rf /text-generation-webui 
fi

# Then link /text-generation-webui  folder to /workspace so it's available in that familiar location as well
ln -s /workspace/text-generation-webui  /text-generation-webui 
