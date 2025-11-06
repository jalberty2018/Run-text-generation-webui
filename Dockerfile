# syntax=docker/dockerfile:1.7
FROM ls250824/pytorch-cuda-ubuntu-runtime:05072025 AS base

# Set working directory
WORKDIR /

# Copy scripts and make them executable
COPY --chmod=755 start.sh onworkspace/text-generation-webui-on-workspace.sh onworkspace/provisioning-on-workspace.sh onworkspace/readme-on-workspace.sh /

# Copy documentation with appropriate permissions
COPY --chmod=644 documentation/README_runpod.md /README.md

# Copy provisioning with appropriate permissions
COPY --chmod=644 provisioning/ /provisioning

# Install oobabooga/text-generation-webui
RUN --mount=type=cache,target=/root/.cache/git \
    git clone https://github.com/oobabooga/text-generation-webui

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

WORKDIR /text-generation-webui

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir "huggingface_hub[cli]" timm \
    -r requirements/full/requirements.txt

# Set workspace directory
WORKDIR /workspace

# Cache directory for Hugging Face
ENV HF_HOME=/workspace/cache

# Expose ports for Gradio, code-server
EXPOSE 7860 9000 

# Labels
LABEL org.opencontainers.image.title="oobabooga text generation webuiwith" \
      org.opencontainers.image.description="VLM and LLM inference" \
      org.opencontainers.image.source="https://hub.docker.com/r/ls250824/run-text-generation-webui" \
      org.opencontainers.image.licenses="MIT"

# Test
RUN python -c "import torch, torchvision, torchaudio, triton; \
print(f'Torch: {torch.__version__}\\nTorchvision: {torchvision.__version__}\\nTorchaudio: {torchaudio.__version__}\\nTriton: {triton.__version__}\\nCUDA available: {torch.cuda.is_available()}\\nCUDA version: {torch.version.cuda}')"

# Start script
CMD [ "/start.sh" ]