# Docker for machine learning with Scala Spark

This project is to collect my [Docker](https://www.docker.com/) for [Scala](https://www.scala-lang.org/), with the purpose of building machine learning-based products. A lot of machine learing practioners start from Python, due to its own strong machine learning and scientific computing communities and open source packages, including Pandas, Scikit-Learn, TensorFlow, among many. Nevertheless, some of ML practioners, including me, would like to step further, into Scala world, to more directly contribute to production. That's why I start this project.

## Docker for Scala

Why Docker and Docker for machine learning? I provided some discussions in the README of my [docker-python3-ml-jupyter](https://github.com/bowen0701/docker-python3-ml-jupyter) repo. For introduction to Docker please refer to it as well, which includes detailed explanations for [DockerFile](https://github.com/bowen0701/docker-python3-ml-jupyter/blob/master/Dockerfile) and [docker-compose.yml](https://github.com/bowen0701/docker-python3-ml-jupyter/blob/master/docker-compose.yml).

Based on the above fundamentals, I start building my own Docker for Scala; please see the following two documents:

- [DockerFile](./Dockerfile)
- [docker-compose.yaml](./docker-compose.yaml)

Note that our Docker is based on basic docker image for **Ubuntu** only, `ubuntu:16.04`. Further, since Scala is built upon Java, but it is very difficult to install the latter by runnning this scripts now: `apt-get install -y oracle-java8-installer`, due to Oracle's action, we adopt **OpenJDK** instead.

Now based on the above two files, we can create our Docker container with Scala by the following procedure:

- Build image by running `docker-compose build`
- Then launch Docker container in background mode by `docker-compose up -d`
- Check Docker container ID by `docker ps`
- ssh into Docker container: `docker exec -it <container_id> \bin\bash`
- Now we can start playing Scala by typing `scala` to go into Scala interpreter, which is also called the **REPL (Read, Evaluate, Print, Loop),** or execute your script file by using `scala <YourScalaFile.scala>`.

<div style="text-align:center">
<img src="/images/docker_scala.png" alt="Drawing" style="width: 500px;"/>
</div>

## Simple Build Tool (sbt)

[Simple Build Tool (sbt)](https://www.scala-sbt.org/) is a build tool for Scala, Java, etc, for easy production, that is, compile our Scala scripts and run the resulting ByteCodes. Our [DockerFile](./Dockerfile) also includes sbt installation.

### Files structure

```
├── build.sbt
├── project
│   ├── plugins.sbt
│   └── build.properties
├── src
│   ├── main
│   │   └── scala
│   │       └── org
│   │           └── Main.scala
└── target
```

To use `sbt` we would like to put our Scala project scripts in a nested directories 

`src/main/scala/com`

Note that "com" is a general-purpose directory name, which could be our comapany, org, or team name, to separate scripts for preventing conflicts.

### build.sbt

`build.sbt` is a sbt file to specify project information and dependencies. For now I just add some simple information.

```
name := "learn-scala-for-ml"

version := "1.0.0"

scalaVersion := "2.12.6"

organization := "org"
```

Note for organization I used a general-purpose word "com", which serves the same role as "com" in nested directories `src/main/scala/com`.

### project/plugins.sbt

With this `sbt-assembly` we can create the jar file from the source file by sbt; see the later discussion.

```
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.5")
```

### sbt Shell

Run the `sbt` commend in the repo folder, this will create "project" folder with generated files, which we can ignore for now. Then in `sbt` shell we can run `compile` commend to compile our Scala scripts in project, or in repo folder we can direct run `sbt compile` to obtain the same result. This will further create "target" folder with generated files, which we can ignore for now as well. The basic `sbt` commands are as follows.

```
cd repo

sbt help

// Login sbt console to Scala REPL mode.
sbt

// Run scalafmt
// TODO: Add details.
scalafmt

// Ccompile the subproject.
sbt <subproject>/compile

// Recommended approach.
sbt <subproject>/assembly
```

## Zeppelin Notebook

Why [Zeppelin Notebook](https://zeppelin.apache.org/)? Since we would like to mimic AWS EMR with Zeppelin Notebook in software configuration already. With Zeppelin Notebook we can write Scala Spark, Python, among others, to perform feature engineering prototyping and machine learning research. Note that [Jupyter Notebook](https://jupyter.org/) with [Apache Toree](https://toree.apache.org/) would be another good option, which will be explored in the near future. 

To install Zeppelin Notebook, for details please see [DockerFile](/DockerFile). Further note that instead of using `CMD` to start Zeppelin Notebook, we use `ENTRYPOINT` to start it and bash shell.

```
ENTRYPOINT $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start && bash
```

TODO: Extending this Docker to contain **Spark.**

Stay tuned. :-)
