FROM ubuntu:22.04

RUN apt-get update && apt-get install -y openjdk-11-jdk

RUN apt-get install -y python3 python3-pip

RUN apt-get install -y gcc g++

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
    libxss1 \
    net-tools

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sh - && apt-get install -y nodejs

RUN curl -fsSL https://code-server.dev/install.sh | sh

ARG USER="mycode"

ARG PASSWORD

RUN useradd -m ${USER} && echo "${USER}:${PASSWORD}" | chpasswd && adduser ${USER} sudo

WORKDIR /home/mycode

EXPOSE 8080

USER mycode

CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]
