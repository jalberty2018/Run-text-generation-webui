# Base image
FROM ls250824/pytorch-cuda-ubuntu-runtime:05072025 AS base

# Set working directory
WORKDIR /

# Copy scripts and make them executable
COPY --chmod=755 start.sh onworkspace/text-generation-webui-on-workspace.sh onworkspace/provisioning-on-workspace.sh onworkspace/readme-on-workspace.sh /

# Copy documentation with appropriate permissions
COPY --chmod=644 documentation/README_runpod.md /README.md

# Copy provisioning with appropriate permissions
COPY --chmod=644 provisioning/ /provisioning

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install oobabooga/text-generation-webui
RUN git clone https://github.com/oobabooga/text-generation-webui && \
    cd text-generation-webui && \
    pip3 install --no-cache-dir -U "huggingface_hub[cli]" \
    -r requirements/full/requirements_cuda128.txt

# Set workspace directory
WORKDIR /workspace

# Expose ports for Gradio, code-server
EXPOSE 7860 9000 

# Start script
CMD [ "/start.sh" ]