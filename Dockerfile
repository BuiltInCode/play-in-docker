FROM openjdk:12-alpine
MAINTAINER James Coon <james@jcoon.dev>

# Establish preliminary path variables
ENV \
    SBT_HOME="/opt/sbt" \
    SBT_VERSION="1.2.8" \
    PLAY_VERSION="2.7.3" \
    SCALA_VERSION="2.13.0" \
    PATH="${PATH}:/opt/sbt/bin"

# Install necessary build tools & install SBT v1.2.8
RUN apk add --no-cache --virtual=.build-deps ca-certificates tar wget && \
    apk add --no-cache bash curl jq && \
    mkdir -p ${SBT_HOME} && \
    wget -qO - --no-check-certificate "https://piccolo.link/sbt-${SBT_VERSION}.tgz" | tar xz -C ${SBT_HOME} --strip-components=1

# Prebuild application with SBT
COPY ./src /tmp/build

RUN cd /tmp/build && \
    sbt ++${SCALA_VERSION}! compile && \
    rm -rf /tmp/

# Finally, remove our build dependencies
RUN apk del .build-deps

# Set up Play! Framework directory and ports
RUN mkdir -p /app
WORKDIR /app
EXPOSE 9000

CMD ["sbt", "run"]
