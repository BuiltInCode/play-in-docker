# Play in Docker (2.7.2)
Play in Docker (PiD) is an easy-to-use, pre-built Docker container that provides the ability to launch your application 
in less than a few minutes!

### Technologies Used
* Java (openjdk:8-slim)
* Scala SBT (1.2.8)
* Play Framework (2.7.2)

### Container Information

#### Exposed Ports
Since Play Framework uses port `9000` to run your web application, this port has been automatically exposed in the 
Dockerfile. You may also bind it to another port, such as `80`, when deploying your container using the `-p` flag. For
example, `-p 80:9000/tcp`.

#### Mapped Volumes
PiD will automatically create the `/app` directory for your project, and then make the `/app` directory the default
working directory for the application. To use this folder, you may add a shared volume between your host machine and
your newly created Docker instance:

`-v /path/to/application:/app:rw`

Since there have also been problems in the past leading to Docker saying "Permission Denied" when inside of the `/app`
folder, you may also have to append the `z` flag to the volume:

`-v /path/to/application:/app:z`

### How to Run

#### Using Docker
Getting started with Docker is simple. The following command will start your Play application up and running bound to 
port `80` and mapped volume to the necessary volume (_this will need to be changed to accommodate your own directory 
structure_):

```console
docker run -dit -p 80:9000/tcp -v /path/to/application:/app:rw jcoon97/play-in-docker:2.7.2
```

#### Using Docker Compose
If you are using docker-compose for your application, the process is also rather simple:

```YAML
[services]
  web:
    image: jcoon97/play-in-docker:2.7.2
    ports:
      - 80:9000/tcp
    stdin_open: true
    volumes:
      - ./:/app:rw
[/services]
```