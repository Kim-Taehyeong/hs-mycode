FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    sudo \
    ca-certificates \
    unzip \
    git \
    wget \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev \
    libnss3-dev \
    libasound2-dev \
    libxtst6 \
    libxss1

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN useradd -m vscode && echo "vscode:vscode" | chpasswd && adduser vscode sudo

WORKDIR /home/vscodebcd

EXPOSE 8080

USER vscode

CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
