# ------------------------------ BUILD ONE (1) ------------------------------
# Build all of the necessary tools and verify that our Play Framework
# application is configured and works correctly with the most recent version
# ---------------------------------------------------------------------------
FROM openjdk:12-alpine AS build

# Establish preliminary environment variables
ARG PLAY_VERSION
ARG SCALA_VERSION
ARG SBT_VERSION

ENV \
    SBT_HOME="/opt/sbt" \
    SBT_VERSION="${SBT_VERSION}" \
    PATH="${PATH}:/opt/sbt/bin"

# Install necessary build tools & install SBT v1.2.8
RUN apk add --no-cache bash ca-certificates curl jq tar wget && \
    mkdir -p ${SBT_HOME} && \
    wget -qO - --no-check-certificate "https://piccolo.link/sbt-${SBT_VERSION}.tgz" | tar xz -C ${SBT_HOME} --strip-components=1

# Prebuild application with SBT
COPY ./src /tmp/build

RUN cd /tmp/build && \
    sbt ++${SCALA_VERSION}! compile && \
    rm -rf /tmp/

# ------------------------------ BUILD TWO (2) ------------------------------
# Using our previous build as a "base," create a new alpine Linux container
# and copy ("extract") all of our built dependencies, such as OpenJDK and
# SBT over to the new project, as well as SBT app/build dependencies
#
# Once that is finished, then install bash for SBT and configure our project
# ---------------------------------------------------------------------------
FROM alpine:latest

ARG PLAY_VERSION
ARG SCALA_VERSION

LABEL name="Play in Docker" \
      maintainer="James Coon <james@jcoon.dev>" \
      version="Play Framework v${PLAY_VERSION}" \
      homepage="https://github.com/BuiltInCode/play-in-docker"

ENV PLAY_VERSION="${PLAY_VERSION}"
ENV SCALA_VERSION="${SCALA_VERSION}"
ENV PATH="${PATH}:/opt/openjdk-12/bin:/opt/sbt/bin"

COPY --from=build /opt /opt
COPY --from=build /root/.sbt /root/.sbt

RUN apk add bash && \
    mkdir -p /app

WORKDIR /app
EXPOSE 9000

CMD ["sbt", "run"]
