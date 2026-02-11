FROM node:22-bookworm

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install common development tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim \
    nano \
    jq \
    build-essential \
    python3 \
    python3-pip \
    openssh-client \
    ca-certificates \
    gnupg \
    ripgrep \
    fd-find \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Set up workspace directory
RUN mkdir -p /workspace
WORKDIR /workspace

# Copy and set up entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["claude"]
