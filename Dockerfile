FROM node:22-slim

RUN apt-get update && apt-get install -y \
    libvulkan1 \
    libatomic1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json qvac.config.json ./
RUN npm install

RUN mkdir -p /root/.qvac/models && \
    curl -L -o /root/.qvac/models/Qwen3-0.6B-Q2_K.gguf \
    "https://huggingface.co/bartowski/Qwen_Qwen3-0.6B-GGUF/resolve/main/Qwen_Qwen3-0.6B-Q2_K.gguf"

EXPOSE 8080

CMD ["node", "node_modules/.bin/qvac", "serve", "openai", "--config", "qvac.config.json", "--port", "8080", "--host", "0.0.0.0", "--cors", "--verbose"]