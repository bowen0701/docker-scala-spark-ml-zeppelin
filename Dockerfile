# Docker settings: Ubuntu, OpenJDK, Scala and Zeppelin Notebook.

FROM ubuntu:16.04

LABEL maintainer="Bowen Li <bowen0701@gmail.com>"

ARG USER_NAME="bowenli"

ARG JDK_VERSION="8"
ARG SCALA_VERSION="2.12.6"
ARG SBT_VERSION="1.1.4"
ARG SPARK_VERSION="2.2.0"
ARG HADOOP_VERSION="2.7"
ARG ZEPPELIN_VERSION="0.7.2"

ENV ZEPPELIN_PORT_NUM 8890

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

# Install Zeppelin
RUN mkdir /usr/zeppelin
RUN curl -s http://mirror.softaculous.com/apache/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz | tar -xz -C /usr/zeppelin

RUN echo '{ "allow_root": true }' > /root/.bowerrc

ENV ZEPPELIN_PORT ${ZEPPELIN_PORT_NUM}
ENV ZEPPELIN_HOME /usr/zeppelin/zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook

RUN mkdir -p ${ZEPPELIN_HOME} \
  && mkdir -p ${ZEPPELIN_HOME}/logs \
  && mkdir -p ${ZEPPELIN_HOME}/run

WORKDIR /${USER_NAME}

# CMD ["/bin/bash"]

ENTRYPOINT $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start && bash
