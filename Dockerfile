FROM node:20-slim

# Install required libraries
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    libatomic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json qvac.config.json ./
RUN npm install

# Pre-download the model at build time for instant startup
RUN npx qvac pull QWEN3_600M_INST_Q4

EXPOSE 11434

CMD ["npx", "qvac", "serve", "openai", "--config", "qvac.config.json", "--port", "11434", "--host", "0.0.0.0", "--cors"]