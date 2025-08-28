# A streamlined setup for running **text-generation-webui**.  

## This pod downloads models as specified in the **environment variables**

- Models are automatically downloaded based on the specified paths in the environment configuration.  
- Authentication credentials can be set via secrets for:  
  - **Code server** authentication (not possible to switch off). 
  - **Hugging Face** tokens for model access.
  - **text-generation-webui** gradio authentication.  

## Hardware Requirements  
 
- **Recommended GPUs**: Nvidia RTX A4500, A40
- **Storage**:  
  - **Volume**: 80GB (`/workspace`)  
  - **Pod Volume**: 5Gb  
  
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

## 📦 **MMPROJ Downloads (multi modality)**

| Model Type     | Hugging Face URL Variable | GGUF File Variable       |
|----------------|---------------------------|---------------------------|
| GGUF MMPROJ     | `HF_MMPROJ_GGUF1`          | `HF_MMPROJ_GGUF_FILE1`     |
| GGUF MMPROJ     | `HF_MMPROJ_GGUF2`          | `HF_MMPROJ_GGUF_FILE2`     |
| GGUF MMPROJ     | `HF_MMPROJ_GGUF3`          | `HF_MMPROJ_GGUF_FILE3`     |
| GGUF MMPROJ     | `HF_MMPROJ_GGUF4`          | `HF_MMPROJ_GGUF_FILE4`     |
| GGUF MMPROJ     | `HF_MMPROJ_GGUF5`          | `HF_MMPROJ_GGUF_FILE5`     |
| GGUF MMPROJ     | `HF_MMPROJ_GGUF6`          | `HF_MMPROJ_GGUF_FILE6`     |

## 🤖 **Transformers Model Downloads**

| Model Type              | Hugging Face URL Variable | Destination Subfolder Variable |
|-------------------------|----------------------------|----------------------------------|
| Transformers   | `HF_MODEL1`                | `HF_MODEL_DIR1`                 |
| Transformers   | `HF_MODEL2`                | `HF_MODEL_DIR2`                 |
| Transformers   | `HF_MODEL3`                | `HF_MODEL_DIR3`                 |
| Transformers   | `HF_MODEL4`                | `HF_MODEL_DIR4`                 |
| Transformers   | `HF_MODEL5`                | `HF_MODEL_DIR5`                 |
| Transformers   | `HF_MODEL6`                | `HF_MODEL_DIR6`                 |

## 🤖 **EXL Model Downloads**

| Model Type            |    Hugging Face URL Variable | Revision | Destination Subfolder Variable |
|-------------------------|----------|------------------|----------------------------------|
| EXL    | `HF_EXL1`  |  `HF_EXL_REVISION1`  |  `HF_EXL_DIR1`                 |
| EXL    | `HF_EXL2`  |  `HF_EXL_REVISION2`  |  `HF_EXL_DIR2`                 |
| EXL    | `HF_EXL3`  |  `HF_EXL_REVISION3`  |  `HF_EXL_DIR3`                 |
| EXL    | `HF_EXL4`  |  `HF_EXL_REVISION4`  |  `HF_EXL_DIR4`                 |
| EXL    | `HF_EXL5`  |  `HF_EXL_REVISION5`  |  `HF_EXL_DIR5`                 |
| EXL    | `HF_EXL6`  |  `HF_EXL_REVISION6`  |  `HF_EXL_DIR6`                 |

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
- [Multi modality](https://github.com/oobabooga/text-generation-webui/wiki/Multimodal-Tutorial)

## Manual provisioning

[example models](provisioning/provisioning.md)