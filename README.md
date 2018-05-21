# Learn Scala for Machine Learning

This project is to collect my practices for learning Scala, with the purpose of building machine learning-based products and targeting people with Python programming background, like me. 

I think the above is a good starting point, because a lot of machine learing practioners start from Python, due to its own strong machine learning and scientific computing communities and open source packages, including Pandas, Scikit-Learn, TensorFlow, among many. Nevertheless, some of ML practioners, including me, would like to step further, into Scala world, to more directly contribute to production. That's why I start this project.

## Docker for Scala

Why **Docker** and Docker for machine learning? I provided some discussions in the README of my [docker-python3-ml-jupyter](https://github.com/bowen0701/docker-python3-ml-jupyter) repo. For introduction to Docker please refer to it as well, which includes detailed explanations for [DockerFile](https://github.com/bowen0701/docker-python3-ml-jupyter/blob/master/Dockerfile) and [docker-compose.yml](https://github.com/bowen0701/docker-python3-ml-jupyter/blob/master/docker-compose.yml).

Based on the above fundamentals, I start building my own Docker for Scala; please see the following two documents:

- [**DockerFile**](./Dockerfile)
- [**docker-compose.yaml**](./docker-compose.yaml)

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

TODO: The future plan for this Docker for Scala is extending it to contain **sbt**, **Spark** and **Zeppelin Notebook.**

Stay tuned. :-)
