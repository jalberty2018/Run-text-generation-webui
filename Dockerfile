# syntax=docker/dockerfile:1.7

FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.13.3 \
    VIRTUAL_ENV=/opt/venv \
    PATH=/opt/venv/bin:/usr/local/bin:$PATH \
    CUDA_HOME=/usr/local/cuda \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH} \
    PIP_NO_CACHE_DIR=1 \
    TORCH_CUDA_ARCH_LIST="8.0;8.6;8.9;9.0;12.0" \
    CUDAARCHS="80;86;89;90;120" \
    CMAKE_BUILD_PARALLEL_LEVEL=16 \
    FORCE_CMAKE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    git-lfs \
    curl \
    wget \
    ca-certificates \
    cmake \
    ninja-build \
    pkg-config \
    ffmpeg \
    libsndfile1 \
    libgl1 \
    libglib2.0-0 \
    libopenblas-dev \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    liblzma-dev \
    uuid-dev \
    tk-dev \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget -q https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xzf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations --with-ensurepip=install && \
    make -j"$(nproc)" && \
    make altinstall && \
    cd / && rm -rf /tmp/Python-${PYTHON_VERSION}*

RUN python3.13 -m venv ${VIRTUAL_ENV} && \
    python -m pip install --upgrade pip setuptools wheel packaging build ninja

# PyTorch 2.9 + CUDA 12.8
RUN python -m pip install \
    --index-url https://download.pytorch.org/whl/cu128 \
    torch==2.9.0 torchvision torchaudio

WORKDIR /

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install oobabooga
RUN git clone --depth=1 https://github.com/oobabooga/textgen.git /textgen

WORKDIR /textgen

# Requirements installeren, maar torch zelf niet opnieuw laten overschrijven
RUN cp requirements/full/requirements.txt /tmp/requirements-full.txt && \
    grep -v -E '^[[:space:]]*(torch|torchvision|torchaudio|flash-attn|flash_attn|exllamav3)([<>=!~ ]|$)' \
      /tmp/requirements-full.txt > /tmp/requirements-patched.txt && \
    python -m pip install -r /tmp/requirements-patched.txt

# Set working directory
WORKDIR /

# Copy scripts and make them executable
COPY --chmod=755 start.sh onworkspace/textgen-on-workspace.sh onworkspace/provisioning-on-workspace.sh onworkspace/readme-on-workspace.sh /

# Copy documentation with appropriate permissions
COPY --chmod=644 documentation/README_runpod.md /README.md

# Copy provisioning with appropriate permissions
COPY --chmod=644 provisioning/ /provisioning

# Set workspace directory
WORKDIR /workspace

# Cache directory for Hugging Face
ENV HF_HOME=/workspace/cache

# Expose ports for Gradio, code-server
EXPOSE 7860 9000 

# Labels
LABEL org.opencontainers.image.title="oobabooga textgen" \
      org.opencontainers.image.description="VLM and LLM inference" \
      org.opencontainers.image.source="https://hub.docker.com/r/ls250824/run-text-generaration-webui" \
      org.opencontainers.image.licenses="MIT"

# Test
RUN python - <<'PY'
import torch
print("torch:", torch.__version__)
print("cuda build:", torch.version.cuda)
print("cuda available:", torch.cuda.is_available())
PY

# Start script
CMD [ "/start.sh" ]
