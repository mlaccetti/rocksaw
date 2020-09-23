#
# RockSaw Testing Container Container
#
# Runs a super-tiny container with Java/Maven/gcc for building/testing RockSaw.
#
# Building the container:
# $ docker build -t mlaccetti/rocksaw-dev .
#
# Interactive usage:
# $ docker run -v $(pwd):/opt/rocksaw -it --rm mlaccetti/rocksaw-dev /bin/bash
#
# If you want to cache Maven dependencies between runs, you can change the run command:
# $ docker run -v $(pwd):/opt/rocksaw -v ~/.m2:/root/.m2 -it --rm mlaccetti/rocksaw-dev /bin/bash
#
# Automated build usage:
# $ docker run -v $(pwd):/opt/rocksaw --rm mlaccetti/rocksaw-dev
#
# Automated build usage with Maven cache:
# $ docker run -v $(pwd):/opt/rocksaw -v ~/.m2:/root/.m2 --rm mlaccetti/rocksaw-dev

FROM adoptopenjdk:11-jdk-hotspot-bionic

LABEL maintainer Michael Laccetti "michael@laccetti.com"

ENV MAVEN_HOME="/opt/maven"
ENV MAVEN_VERSION="3.6.3"

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y build-essential curl vim maven

WORKDIR /opt/rocksaw

COPY . /opt/rocksaw

CMD ["mvn", "clean", "test"]
