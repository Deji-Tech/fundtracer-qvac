FROM node:20-slim

# Install Vulkan + Mesa CPU drivers for software rendering (llvmpipe)
RUN apt-get update && apt-get install -y \
    libvulkan1 \
    mesa-vulkan-drivers \
    libglx-mesa0 \
    libwayland-egl1 \
    libx11-xcb1 \
    libxcb-dri0 \
    libxcb-render0 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libdrm2 \
    libpciaccess0 \
    libuuid1 \
    liblz4-1 \
    libzstd1 \
    libstdc++6 \
    libc6 \
    libgcc-s1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json qvac.config.json ./
RUN npm install

EXPOSE 11434

CMD ["npx", "qvac", "serve", "openai", "--config", "qvac.config.json", "--port", "11434", "--host", "0.0.0.0", "--cors"]