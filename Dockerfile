FROM node:20-slim

# Install required libraries
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    libatomic1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json qvac.config.json ./
RUN npm install

# Pre-download model at build time (~400MB)
RUN mkdir -p /root/.qvac/models && \
    curl -L -o /root/.qvac/models/Qwen3-0.6B-Q4_0.gguf \
    "https://huggingface.co/bartowski/Qwen_Qwen3-0.6B-GGUF/resolve/main/Qwen_Qwen3-0.6B-Q4_0.gguf"

EXPOSE 11434

# Use shell to read PORT env var
CMD sh -c "npx qvac serve openai --config qvac.config.json --port $PORT --host 0.0.0.0 --cors"