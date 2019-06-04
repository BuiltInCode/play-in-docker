FROM openjdk:8-slim
MAINTAINER James Coon <james@jcoon.dev>

ENV JAVA_HOME /usr/local/openjdk-8
ENV PATH $PATH:/usr/local/openjdk-8:/usr/local/jre/openjdk-8/jre/bin
ENV SBT_VERSION 1.2.8

# Install cURL
RUN \
    apt-get update && \
    apt-get -y install curl

# Install SBT (for Play)
RUN \
    curl -L -o sbt-${SBT_VERSION}.deb https://dl.bintray.com/sbt/debian/sbt-${SBT_VERSION}.deb && \
    dpkg -i sbt-${SBT_VERSION}.deb && \
    rm sbt-${SBT_VERSION}.deb && \
    apt-get update && \
    apt-get -y install sbt

# Prebuild w/ SBT
COPY ./src/ /tmp/build/

RUN \
    cd /tmp/build/ && \
    sbt compile && \
    sbt test:compile && \
    rm -rf /tmp/build/

# Set up Play! Framework directory and ports
RUN mkdir -p /app
WORKDIR /app
EXPOSE 9000

CMD ["sbt", "run"]