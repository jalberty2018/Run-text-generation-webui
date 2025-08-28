#!/bin/bash

echo "[INFO] Pod run-text-generation-webui started"

# ssh scp ftp on (TCP port 22)

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start 
fi

# Move necessary files to workspace
for script in text-generation-webui-on-workspace.sh provisioning-on-workspace.sh readme-on-workspace.sh; do
    if [ -f "/$script" ]; then
        echo "Executing $script..."
        "/$script"
    else
        echo "⚠️ WARNING: Skipping $script (not found)"
    fi
done

# Login to Hugging Face if token is provided
if [[ -n "$HF_TOKEN" ]]; then
    hf auth login --token "$HF_TOKEN"
else
	echo "⚠️ WARNING: HF_TOKEN is not set as an environment variable"
fi

# GPU detection
HAS_GPU=0
if [[ -n "${RUNPOD_GPU_COUNT:-}" && "${RUNPOD_GPU_COUNT:-0}" -gt 0 ]]; then
  HAS_GPU=1
elif command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi >/dev/null 2>&1 && HAS_GPU=1 || true
elif [[ -n "${CUDA_VISIBLE_DEVICES:-}" && "${CUDA_VISIBLE_DEVICES}" != "-1" ]]; then
  HAS_GPU=1
fi

# Run services
if [[ "$HAS_GPU" -eq 1 ]]; then
    # Start code-server (HTTP port 9000)
    if [[ -n "$PASSWORD" ]]; then
        code-server /workspace --auth password --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    else
        echo "⚠️ WARNING: PASSWORD is not set as an environment variable"
        code-server /workspace --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    fi
	
	sleep 5

	# Start text-generation-webui (HTTP port 7860)
	cd /workspace/text-generation-webui/
	
	if [[ -n "$GRADIO_AUTH" ]]; then
       python3 server.py --gradio-auth "$GRADIO_AUTH" --listen &
	else
	   echo "⚠️ WARNING: GRADIO_AUTH (user:password) is not set as an environment variable"
	   python3 server.py --listen &
	fi
	
	sleep 5
	
	# Confirmation	
	echo "[INFO] Code Server & text-generation-webui started"
	
else
    echo "⚠️ WARNING: No GPU available, text-generation-webui, Code Server not started to limit memory use"
fi

# --- Download helpers ---

download_model_HF_GGUF() {
  local model_var="$1" file_var="$2"
  local model="${!model_var:-}" file="${!file_var:-}"
  if [[ -n "$model" && -n "$file" ]]; then
    echo "[INFO] Downloading GGUF model: $model ($file)"
    hf download "$model" "$file" --local-dir "/workspace/text-generation-webui/user_data/models/"
    sleep 1
  fi
}

download_mmproj_HF_GGUF() {
  local model_var="$1" file_var="$2"
  local model="${!model_var:-}" file="${!file_var:-}"
  if [[ -n "$model" && -n "$file" ]]; then
    echo "[INFO] Downloading GGUF mmproj: $model ($file)"
    hf download "$model" "$file" --local-dir "/workspace/text-generation-webui/user_data/mmproj/"
    sleep 1
  fi
}

download_model_HF() {
  local model_var="$1" dest_dir_var="$2"
  local model="${!model_var:-}" dest_dir="${!dest_dir_var:-}"
  if [[ -n "$model" && -n "$dest_dir" ]]; then
    echo "[INFO] Downloading model repo: $model -> $dest_dir"
    hf download "$model" --local-dir "/workspace/text-generation-webui/user_data/models/$dest_dir/"
    sleep 1
  fi
}

download_EXL_HF() {
  local model_var="$1" revision_var="$2" dest_dir_var="$3"
  local model="${!model_var:-}" revision="${!revision_var:-}" dest_dir="${!dest_dir_var:-}"
  if [[ -n "$model" && -n "$revision" && -n "$dest_dir" ]]; then
    echo "[INFO] Downloading EXL repo: $model (rev: $revision) -> $dest_dir"
    hf download "$model" --revision "$revision" --local-dir "/workspace/text-generation-webui/user_data/models/$dest_dir/"
    sleep 1
  fi
}

echo "[INFO] Provisioning started"

# GGUF (single files)
for i in {1..6}; do
  download_model_HF_GGUF "HF_MODEL_GGUF${i}" "HF_MODEL_GGUF_FILE${i}"
done

# mmproj (single files)
for i in {1..6}; do
  download_mmproj_HF_GGUF "HF_MMPROJ_GGUF${i}" "HF_MMPROJ_GGUF_FILE${i}"
done

# Full repos (into subdirs)
for i in {1..6}; do
  download_model_HF "HF_MODEL${i}" "HF_MODEL_DIR${i}"
done

# EXL repos with explicit revision
for i in {1..6}; do
  download_EXL_HF "HF_EXL${i}" "HF_EXL_REVISION${i}" "HF_EXL_DIR${i}"
done

echo "✅ Provisioning completed."

# Keep the container running
exec sleep infinity
