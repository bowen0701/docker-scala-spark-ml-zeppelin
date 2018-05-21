# Docker settings: Ubuntu, OpenJDK, and Scala.

FROM ubuntu:16.04

LABEL maintainer="Bowen Li <bowen0701@gmail.com>"

ARG JDK_VERSION="8"
ARG SCALA_VERSION="2.12.6"
ARG SBT_VERSION="1.1.4"

# Install basic libraris and Open JDK.
RUN apt-get update && apt-get install -y \
        wget \
        curl \
        vim \
        unzip \
        software-properties-common \
        openjdk-$JDK_VERSION-jdk \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Scala.
RUN wget www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb && \
    dpkg -i scala-$SCALA_VERSION.deb && \
    rm scala-$SCALA_VERSION.deb

# Install sbt.
RUN curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

WORKDIR /bowenli

# CMD ["/bin/bash"]
