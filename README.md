# Play in Docker (v2.7.3)
[Play in Docker](https://cloud.docker.com/repository/docker/jcoon97/play-in-docker) is an easy-to-use, lightweight 
Docker image that allows developers to get up-and-running using the latest version of Play Framework within minutes!

![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/BuiltInCode/play-in-docker.svg?label=Latest%20Version&style=popout)
![CircleCI](https://img.shields.io/circleci/build/gh/BuiltInCode/play-in-docker/master.svg?label=Current%20Build%20State&style=popout)
![Docker Pulls](https://img.shields.io/docker/pulls/jcoon97/play-in-docker.svg?label=Docker%20Downloads&style=popout)
![GitHub](https://img.shields.io/github/license/BuiltInCode/play-in-docker.svg?label=License%20Model&style=popout)

## Technologies Used
* [Java](https://hub.docker.com/_/openjdk) — `openjdk:12-alpine`
* [Scala](https://www.scala-lang.org/) — `2.13.0`
* [Scala Build Tools](https://www.scala-sbt.org/) ("SBT") — `1.2.8`
* [Play Framework](https://www.playframework.com/) — `2.7.3`

## Getting Started
Getting started with Play in Docker is simple; the following sections will outline how, with very little configuration, 
you can be up-and-running and building your application within as little as a few minutes!

### Application Setup
Before we may begin setting up the Docker-side of Play in Docker, there are a few steps that _should be_  addressed 
within our application's root directory first. 

Although our application will run without the following modifications, making sure that all of the issues have been 
addressed will only take a minute and will ensure that we are running the most up-to-date version of Play Framework and 
its dependencies.

#### Update `sbt-plugin` in `project/plugins.sbt`
When SBT is booting your application, it will first check our `project/plugins.sbt` file to ensure that 
is has properly loaded all of our necessary dependencies; however, the core Play Framework plugin is also located 
there, as well.

Open `project/plugins.sbt` using your favorite text editor or IDE and modify the following line to coincide with the 
version of Play in Docker you will be using (currently running `2.7.3`):

```scala
addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.7.3")
```

#### Update `scalaVersion` in `build.sbt`
When Scala is downloaded for our use, SBT will be handling this operation. So, if we wish to force which version of 
Scala that is download and that we will subsequently be using to write our application, open `build.sbt` with your 
favorite text editor or IDE and add _or_ modify the following line to correspond with the latest version of Scala:

```scala
scalaVersion := "2.13.0"
```

#### Update `sbt.version` in `project/build.properties`
Finally, since SBT is our build tool, we want to be vigilant in ensuring that we are using the most recent (_stable_) 
version of it, too.

To enforce this logic, open `project/build.properties` with your favorite text editor or IDE. Once it has opened, we 
are greeted with one line and it defines `sbt.version=?`. Replace with the `?` with the most recent version of SBT that 
we wish to use.

```scala
sbt.version=1.2.8
```  

### Docker Setup
Now that we have ensured that our application will run the latest version of Play Framework, as well as all of our 
required dependencies, we may now use `Docker CLI` or configure a `docker-compose.yml` file to use Play in Docker.

#### Docker CLI Configuration
At its most basic level, Play in Docker can simply be pulled from [Docker Hub](https://cloud.docker.com/repository/docker/jcoon97/play-in-docker) 
and spun up using Docker's CLI tools.

To continue with this approach in spinning up a vanilla, bare-bones version of Play in Docker, please execute the 
following shell command:

```shell
docker run -dt jcoon97/play-in-docker:latest
```

As is rather evident upon executing the previous command, we did not specify any additional flags that would have 
allowed us to have any flexibility over the application it is running, bound port(s), or bound volume(s) — it simply 
pulled `jcoon97/play-in-docker:latest` from [Docker Hub](https://cloud.docker.com/repository/docker/jcoon97/play-in-docker/) 
and began running a vanilla project in which we had no control over.

To demonstrate how we may add more functionality, such as bound port(s) and/or bound volume(s), you may also execute 
the following statement that will spin up a new container of Play in Docker that will route `port 80` to our web server 
**and** will volume map our local application directory to our pre-created `/app` directory within Docker so we may 
now view live, hot-reloaded code changes:

```shell
docker run -d -p 80:9000/tcp -v /path/to/application:/app:rw -t jcoon97/play-in-docker:latest
```

> Throughout our use of `docker run`, we have used `-d` flag, which, when Docker is spinning up, will force the 
  container to become _detached_ and run in the background. If you wish to have it run in the foreground, however, 
  simply remove the `-d` flag to view the console log(s)/output.

#### `docker-compose.yml` Configuration
If you've used Docker for any amount of time, you've probably come across or used Docker Compose. As a developer, 
Docker Compose will offer you most of — if not only marginally less — control with Docker versus using the Docker CLI.

However, with Docker Compose employing an easy-to-read/easy-to-understand YAML file to outline services and allow for 
vast configuration over our Docker components, while also providing a static file that can be used to interact with our 
container(s) versus copying & pasting or constantly writing commands, it is an extremely helpful tool for any person or
organization that wishes to use Docker in the long-term.

Therefore, getting Play in Docker up-and-running within Docker Compose is a trivial task that should take less than a 
few minutes to get configured.

Please see the following code snippet to understand how we can leverage Docker Compose to run our Play in Docker image.

```YAML
[services]
  play:
    image: jcoon97/play-in-docker:latest
    ports:
      - 80:9000/tcp
    stdin_open: true
    volumes:
      - ./:/app:rw
[/services]
```

Now that we have successfully configured our `docker-compose.yml` file to launch with Play in Docker, it is now simply 
a matter of executing `docker-compose up` and our server is now live!

## Additional Information

### Dependency Incompatibilities
Play Framework is rather vigilant about ensuring that they are consistently running the most recent version(s) of their 
dependencies. As such, when Play Framework is updated, there is potential that one — or more — of our dependencies may 
fail to load due to version mismatching, which is typically the most common when API code is changed or once-deprecated 
methods have officially been removed.

If this happens to you, please narrow down and understand which dependency is the culprit and reach out to the 
appropriate development team so that it may be resolved swiftly.

On the other hand, if an issue arises that is related to Play in Docker, please [click here](https://github.com/BuiltInCode/play-in-docker/issues) 
to visit our **Issues** page and report it there.

### Port Binding(s)
When Play Framework is running as a service, it will bind itself to `port 9000` to broadcast the underlying Akka HTTP 
server. This port is exported via our `Dockerfile` and compiled/released with Play in Docker.

Furthermore, if no port mapping is defined, we will be able to access our Play Framework server by navigating to 
`http://localhost:9000/` using our favorite web browser. However, as this setup may not be ideal for everyone, Docker 
also gives everyone rather extensive control over how host ports may be mapped to container ports (and vice-versa).

If you are interested in learning how we may go about configuring our port binding(s), please consult the **Getting 
Started**  section above, as the provided examples demonstrate how we redirected `port 80` on our host machine to 
`port 9000` within our container.

### Volume Binding(s)
Since Play in Docker requires application code to function properly, volume mappings are how we communicate with the 
host filesystem for features, such as hot-reload; however, it is also how we communicate with the container's 
filesystem, as well.

When Play in Docker is built and distributed, a directory — `/app` — is automatically created as a guide to where our 
application code must live (for as long as you use Play in Docker, at least).

Docker has excellent documentation surrounding [volumes](https://docs.docker.com/storage/volumes/)  and how you may use 
them; however, for our purposes, we will only be addressing the most basic features that are necessary to get us 
up-and-running.

If we are using the Docker command-line interface ("CLI") to launch Play in Docker, we may specify a volume mapping that 
will correspond with our host application directory and our container `/app` directory:

`-v /path/to/application:/app:rw`

> When configuring volume maps in Docker, it must be understood that Docker **prohibits** relative paths 
  when using the CLI. However, where the Docker CLI will force users to use absolute paths, Docker Compose does _not_ 
  enforce this constraint, as can be demonstrated with the following piece of code: `./:/app:rw`

## License
```
The MIT License

Copyright (c) 2019 BuiltInCode. https://github.com/BuiltInCode

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
