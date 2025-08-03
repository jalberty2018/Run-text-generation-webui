[![Docker Image Version](https://img.shields.io/docker/v/ls250824/run-text-generation-webui)](https://hub.docker.com/r/ls250824/run-text-generation-webui)

# Run text-generation-webui on [RunPod.io](https://runpod.io?ref=se4tkc5o)

## Synopsis

A streamlined setup for running **text-generation-webui**.  
This pod downloads models as specified in the **environment variables**

- Models are automatically downloaded based on the specified paths in the environment configuration.  
- Authentication credentials can be set via secrets for:  
  - **Code server** authentication (not possible to switch off). 
  - **Hugging Face** tokens for model access.
  - **text-generation-webui** gradio authentication.  

Ensure that the required environment variables and secrets are correctly set before running the pod.
See below for options.

## Hardware Requirements  
 
- **Recommended GPUs**: Nvidia RTX A4500, A40
- **Storage**:  
  - **Volume**: 80GB (`/workspace`)  
  - **Pod Volume**: 10Gb  

## Available Images

### Base Images 

#### ls250824/pytorch-cuda-ubuntu-runtime
	
[![Docker Image Version](https://img.shields.io/docker/v/ls250824/pytorch-cuda-ubuntu-runtime)](https://hub.docker.com/r/ls250824/pytorch-cuda-ubuntu-runtime)

### Custom Build: 

```bash
docker pull ls250824/run-text-generation-webui:<version>
```

## Environment Variables  

### **Authentication Tokens**  

| Token        | Environment Variable | Example |
|--------------|----------------------|---------|
| Huggingface  | `HF_TOKEN`           | token |
| Code Server  | `PASSWORD`           | password |
| Gradio       | `GRADIO_AUTH`        | user:password |

## 📦 **GGUF Model Downloads**

| #  | Model Type     | Hugging Face URL Variable | GGUF File Variable       |
|----|----------------|---------------------------|---------------------------|
| 1  | GGUF Model     | `HF_MODEL_GGUF1`          | `HF_MODEL_GGUF_FILE1`     |
| 2  | GGUF Model     | `HF_MODEL_GGUF2`          | `HF_MODEL_GGUF_FILE2`     |
| 3  | GGUF Model     | `HF_MODEL_GGUF3`          | `HF_MODEL_GGUF_FILE3`     |
| 4  | GGUF Model     | `HF_MODEL_GGUF4`          | `HF_MODEL_GGUF_FILE4`     |
| 5  | GGUF Model     | `HF_MODEL_GGUF5`          | `HF_MODEL_GGUF_FILE5`     |
| 6  | GGUF Model     | `HF_MODEL_GGUF6`          | `HF_MODEL_GGUF_FILE6`     |

## 🤖 **Transformers & EXL2 Model Downloads**

| #  | Model Type              | Hugging Face URL Variable | Destination Subfolder Variable |
|----|-------------------------|----------------------------|----------------------------------|
| 1  | Transformers / EXL2    | `HF_MODEL1`                | `HF_MODEL_DIR1`                 |
| 2  | Transformers / EXL2    | `HF_MODEL2`                | `HF_MODEL_DIR2`                 |
| 3  | Transformers / EXL2    | `HF_MODEL3`                | `HF_MODEL_DIR3`                 |
| 4  | Transformers / EXL2    | `HF_MODEL4`                | `HF_MODEL_DIR4`                 |
| 5  | Transformers / EXL2    | `HF_MODEL5`                | `HF_MODEL_DIR5`                 |
| 6  | Transformers / EXL2    | `HF_MODEL6`                | `HF_MODEL_DIR6`                 |

## Connection options 

### Services

| Service         | Port          |
|-----------------|---------------| 
| **Code Server** | `9000` (HTTP) |
| **SSH/SCP**     | `22`   (TCP)  |
| **Gradio**      | `7860` (HTTP) |

## Website models

- [Huggingface](https://huggingface.co/)

## Websites software Github

- [Code server](https://github.com/coder/code-server)
- [text-generation-webui](https://github.com/oobabooga/text-generation-webui)