# Docker settings: Ubuntu, OpenJDK, and Scala.

FROM ubuntu:16.04

LABEL maintainer="Bowen Li <bowen0701@gmail.com>"

ARG SCALA_VERSION="2.12.6"

# Install basic libraris and Open JDK.
RUN apt-get update && apt-get install -y \
        wget \
        curl \
        vim \
        unzip \
        software-properties-common \
        default-jdk \
        && \
    # add-apt-repository ppa:webupd8team/java && \
    # apt-get update && \
    # apt-get install -y oracle-java8-installer && \
    # apt-get remove --purge getdeb-repository && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Scala.
RUN wget www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb && \
    dpkg -i scala-$SCALA_VERSION.deb

WORKDIR /bowenli

# CMD ["/bin/bash"]
