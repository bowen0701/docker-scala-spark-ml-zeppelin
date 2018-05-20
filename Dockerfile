# Docker settings: Ubuntu, Scala.

FROM ubuntu:16.04

LABEL maintainer="Bowen Li <bowen0701@gmail.com>"

ARG SCALA_VERSION="2.12.6"

# Install basic libraris and JAVA 8.
RUN apt-get update && apt-get install -y \
        curl \
        vim \
        unzip \
        software-properties-common \
        && \
    apt-add-repository ppa:webupd8team/java && \
    apt-get install oracle-java8-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Scala.
RUN wget www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb && \
    dpkg -i scala-$SCALA_VERSION.deb

WORKDIR /bowenli
