FROM gg77/jdk-8-oracle

RUN echo '2017-12-01' && \
    apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
      autoconf \
      automake \
      bison \
      build-essential \
      curl \
      flex \
      g++ \
      git \
      libboost-dev \
      libboost-program-options-dev \
      libboost-test-dev \
      libevent-dev \
      libssl-dev \
      libtool \
      make \
      maven \
      pkg-config \
      unzip && \
    rm -rf /var/lib/apt/lists/* /var/cache/*

ARG PROTOBUF_VERSION=3.2.0
RUN wget https://github.com/google/protobuf/archive/v$PROTOBUF_VERSION.tar.gz -O protobuf.tar.gz && \
    tar xzf protobuf.tar.gz && \
    cd protobuf* && \
    ./autogen.sh && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    ldconfig && \
    rm ../protobuf.tar.gz

# https://issues.apache.org/jira/browse/THRIFT-1300
ARG THRIFT_VERSION=0.7.0
RUN wget https://archive.apache.org/dist/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz -O thrift.tar.gz && \
    tar xzf thrift.tar.gz && \
    cd thrift* && \
    chmod +x ./configure && \
    ./configure --disable-gen-erl --disable-gen-hs --without-ruby --without-haskell --without-erlang --without-php && \
    make install && \
    rm ../thrift.tar.gz

RUN git clone https://github.com/apache/parquet-mr
WORKDIR parquet-mr

ENV HADOOP_PROFILE=default

RUN LC_ALL=C mvn install --batch-mode -DskipTests=true -Dmaven.javadoc.skip=true -Dsource.skip=true
WORKDIR parquet-cli
RUN mvn clean install -DskipTests
