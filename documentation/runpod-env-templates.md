# Runpod templates

## public

```bash
HF_MODEL_GGUF1=saukko/Abliterated-Dolphin3.0-R1-Mistral-24B-GGUF
HF_MODEL_GGUF_FILE1=Abliterated-Dolphin3.0-R1-Mistral-24B-Q8_0.gguf
```

## private

### GemmaVL

```bash
HF_TOKEN="{{ RUNPOD_SECRET_HF_TOKEN_WRITE }}"
PASSWORD="{{ RUNPOD_SECRET_CODE-SERVER-NEW }}"
GRADIO_AUTH="{{ RUNPOD_SECRET_Gradio_auth }}"
HF_MODEL_GGUF1=mlabonne/gemma-3-27b-it-abliterated-GGUF
HF_MODEL_GGUF_FILE1=gemma-3-27b-it-abliterated.q8_0.gguf
HF_MMPROJ_GGUF1=mlabonne/gemma-3-27b-it-abliterated-GGUF
HF_MMPROJ_GGUF_FILE1=mmproj-mlabonne_gemma-3-27b-it-abliterated-f16.gguf
```

### QwenVL

```bash
HF_TOKEN="{{ RUNPOD_SECRET_HF_TOKEN_WRITE }}"
PASSWORD="{{ RUNPOD_SECRET_CODE-SERVER-NEW }}"
GRADIO_AUTH="{{ RUNPOD_SECRET_Gradio_auth }}"
HF_MODEL_GGUF1=mradermacher/Qwen2.5-VL-7B-Instruct-abliterated-GGUF
HF_MODEL_GGUF_FILE1=Qwen2.5-VL-7B-Instruct-abliterated.f16.gguf
HF_MMPROJ_GGUF1=mradermacher/Qwen2.5-VL-7B-Instruct-abliterated-GGUF
HF_MMPROJ_GGUF_FILE1=Qwen2.5-VL-7B-Instruct-abliterated.mmproj-f16.gguf
```

### LLM

```bash
HF_TOKEN="{{ RUNPOD_SECRET_HF_TOKEN_WRITE }}"
PASSWORD="{{ RUNPOD_SECRET_CODE-SERVER-NEW }}"
GRADIO_AUTH="{{ RUNPOD_SECRET_Gradio_auth }}"
HF_MODEL_GGUF1=saukko/Abliterated-Dolphin3.0-R1-Mistral-24B-GGUF
HF_MODEL_GGUF_FILE1=Abliterated-Dolphin3.0-R1-Mistral-24B-Q8_0.gguf
```