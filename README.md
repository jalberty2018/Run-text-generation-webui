# Run text-generation-webui on [RunPod.io](https://runpod.io?ref=se4tkc5o)

[![Docker Image Version](https://img.shields.io/docker/v/ls250824/run-text-generation-webui)](https://hub.docker.com/r/ls250824/run-text-generation-webui)

## This pod downloads models as specified in the **environment variables**

- Models are automatically downloaded based on the specified paths in the environment configuration.  
- Authentication credentials can be set via secrets for:  
  - **Code server** authentication (not possible to switch off). 
  - **Hugging Face** tokens for model access.
  - **text-generation-webui** gradio authentication.  

## 📦 Template Deployment

👉 [**One-click Deploy on RunPod**](https://console.runpod.io/deploy?template=u62v7rqcqw&ref=se4tkc5o)

## Hardware Requirements  
 
- **Recommended GPUs**: Nvidia RTX A4500, A40
- **Storage**:  
  - **Volume**: 80GB (`/workspace`)  
  - **Pod Volume**: 15Gb  

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

| Token        | Environment Variable | Example | Required |
|--------------|----------------------|---------|----------|
| Hugging face  | `HF_TOKEN`           | token | ✅ Yes |
| Code Server  | `PASSWORD`           | password | Optional |
| text-generation-webui       | `GRADIO_AUTH`        | user:password | Optional |

## 📦 **GGUF Model Downloads**

| Model Type     | Hugging Face URL Variable | GGUF File Variable       |
|----------------|---------------------------|---------------------------|
| GGUF Model     | `HF_MODEL_GGUF1`          | `HF_MODEL_GGUF_FILE1`     |
| GGUF Model     | `HF_MODEL_GGUF2`          | `HF_MODEL_GGUF_FILE2`     |
| GGUF Model     | `HF_MODEL_GGUF3`          | `HF_MODEL_GGUF_FILE3`     |
| GGUF Model     | `HF_MODEL_GGUF4`          | `HF_MODEL_GGUF_FILE4`     |
| GGUF Model     | `HF_MODEL_GGUF5`          | `HF_MODEL_GGUF_FILE5`     |
| GGUF Model     | `HF_MODEL_GGUF6`          | `HF_MODEL_GGUF_FILE6`     |

## 🤖 **Transformers & EXL2 Model Downloads**

| Model Type              | Hugging Face URL Variable | Destination Subfolder Variable |
|-------------------------|----------------------------|----------------------------------|
| Transformers / EXL2    | `HF_MODEL1`                | `HF_MODEL_DIR1`                 |
| Transformers / EXL2    | `HF_MODEL2`                | `HF_MODEL_DIR2`                 |
| Transformers / EXL2    | `HF_MODEL3`                | `HF_MODEL_DIR3`                 |
| Transformers / EXL2    | `HF_MODEL4`                | `HF_MODEL_DIR4`                 |
| Transformers / EXL2    | `HF_MODEL5`                | `HF_MODEL_DIR5`                 |
| Transformers / EXL2    | `HF_MODEL6`                | `HF_MODEL_DIR6`                 |

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

## Manual provisioning

[example models](provisioning/provisioning.md)

## Building the Docker Image 

This is not possible on [runpod.io](https://runpod.io?ref=se4tkc5o) use local hardware.
You can build and push the image to Docker Hub using the `build-docker.py` script.

### `build-docker.py` script options

| Option         | Description                                         | Default                |
|----------------|-----------------------------------------------------|------------------------|
| `--username`   | Docker Hub username                                 | Current user           |
| `--tag`        | Tag to use for the image                            | Today's date           |
| `--latest`     | If specified, also tags and pushes as `latest`      | Not enabled by default |

### Build & push Command

Run the following command to clone the repository and build the image:

```bash
git clone https://github.com/jalberty2018/run-text-generation-webui.git
cp run-text-generation-webui/build-docker.py ..

python3 build-docker.py \
--username=<your_dockerhub_username> \
--tag=<custom_tag> \ 
run-text-generation-webui
```

Note: If you want to push the image with the latest tag, add the --latest flag at the end.




