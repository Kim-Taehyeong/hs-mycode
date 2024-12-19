FROM ubuntu:22.04

ENV TZ=Asia/Seoul
ENV DEBIAN_FRONTEND=noninteractive

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
    net-tools \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    gcc \
    g++ \
    tzdata \
    python3.10-venv \
    vim \
    iputils-ping \
    xinetd \
    apt-transport-https \
    gpg

RUN curl -sL https://deb.nodesource.com/setup_22.x | sudo bash -E -

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN sudo mkdir -p -m 755 /etc/apt/keyrings

RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && \
    apt-get install -y \
    kubectl \
    nodejs


ARG USER="mycode"

ARG PASSWORD

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -m ${USER} && echo "${USER}:${PASSWORD}" | chpasswd && adduser ${USER} sudo

WORKDIR /home/mycode

EXPOSE 8080
EXPOSE 3000
EXPOSE 3001

USER mycode

CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]

