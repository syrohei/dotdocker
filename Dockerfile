FROM ubuntu:xenial
MAINTAINER syrohei

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# make sure apt is up to date
RUN apt-get update --fix-missing
RUN apt-get install -y curl wget build-essential libssl-dev ssh

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.9.2
ENV GO_VERSION 1.7.4
ENV GO_OS_ARCH linux-amd64

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN wget https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go$GO_VERSION.$GO_OS_ARCH.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin


CMD ["node"] 
