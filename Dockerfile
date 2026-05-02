FROM node:22-slim

# Install required libraries for Vulkan/GPU support
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    libatomic1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json qvac.config.json ./
RUN npm install

ENV PORT=8080

EXPOSE 8080

# Run directly with verbose logging to see startup issues
CMD node_modules/.bin/qvac serve openai --config qvac.config.json --port 8080 --host 0.0.0.0 --cors --verbose