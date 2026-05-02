FROM node:20-slim

# Install Vulkan + Mesa CPU drivers for software rendering (llvmpipe)
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    mesa-vulkan-drivers \
    libglx-mesa0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json qvac.config.json ./
RUN npm install

EXPOSE 11434

CMD ["npx", "qvac", "serve", "openai", "--config", "qvac.config.json", "--port", "11434", "--host", "0.0.0.0", "--cors"]