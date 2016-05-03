FROM mhart/alpine-node:4.4.3
MAINTAINER NG2 Webpack Team <cfulnecky@gmail.com>

ENV HOME /home/yeoman

# Update and install necessary dependencies
RUN apk update && apk add \
    bash \
    make \
    gcc \
    g++ \
    python \
    tar \
    git \
    zip \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /home/yeoman/client
RUN addgroup yeoman && \
    adduser -h $HOME -D -s /bin/bash -G yeoman yeoman

#COPY package.json $HOME/package.json

# Install ng2-webpack via yo
WORKDIR $HOME

RUN npm install --global yo

USER yeoman

RUN npm install generator-ng2-webpack



RUN cd $HOME/client && \
    yo ng2-webpack --name="demo" --clientFolder="src"

# Expose volumes for long term data storage
VOLUME /client

# Exposing tcp port
EXPOSE 9000

CMD ["npm", "start"]
