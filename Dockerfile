FROM ubuntu:latest

ENV SOURCE_REPO https://github.com/official-stockfish/Stockfish
ENV VERSION master

RUN apt-get update \
 && apt-get install -y bash make gcc g++ \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/apt/* 

ADD ${SOURCE_REPO}/archive/${VERSION}.tar.gz /root
WORKDIR /root

RUN if [ ! -d Stockfish-${VERSION} ]; then tar xvzf *.tar.gz; fi \
  && cd Stockfish-${VERSION}/src \
  && make build ARCH=x86-64-modern \
  && make install \
  && cd ../.. && rm -rf Stockfish-${VERSION} *.tar.gz


CMD /bin/bash
