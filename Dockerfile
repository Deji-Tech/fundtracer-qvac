FROM node:20-slim

# Install required libraries for QVAC
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    libatomic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json qvac.config.json ./
RUN npm install

EXPOSE 11434

CMD ["npx", "qvac", "serve", "openai", "--config", "qvac.config.json", "--port", "11434", "--host", "0.0.0.0", "--cors"]