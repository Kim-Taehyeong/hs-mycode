FROM taehyeok02/default-environment:v1.0

ENV TZ=Asia/Seoul
ENV DEBIAN_FRONTEND=noninteractive

RUN curl -fsSL https://code-server.dev/install.sh | sh

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

