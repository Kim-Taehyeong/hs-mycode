FROM ubuntu:22.04

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sh -

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
    net-tools \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    gcc \
    g++ \
    nodejs \
    tzdata


RUN curl -fsSL https://code-server.dev/install.sh | sh

ARG USER="mycode"

ARG PASSWORD

ENV TZ=Asia/Seoul

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -m ${USER} && echo "${USER}:${PASSWORD}" | chpasswd && adduser ${USER} sudo

WORKDIR /home/mycode

EXPOSE 8080

USER mycode

CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]
