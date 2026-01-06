FROM --platform=linux/amd64 debian:bookworm-slim

RUN apt-get update && apt-get install -y wabt binaryen wget ca-certificates
RUN wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-29/wasi-sdk-29.0-x86_64-linux.tar.gz -O wasi-sdk.tar.gz && \
    tar -zxvf wasi-sdk.tar.gz && \
    rm wasi-sdk.tar.gz
WORKDIR /usr/src/onigmo
CMD PATH=$PATH:/wasi-sdk-29.0-x86_64-linux/bin ./script/build-wasm.sh
