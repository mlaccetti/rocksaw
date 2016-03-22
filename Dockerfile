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

FROM anapsix/alpine-java:jdk8

MAINTAINER Michael Laccetti "michael@laccetti.com"

ENV MAVEN_HOME="/opt/maven"
ENV MAVEN_VERSION="3.3.9"

RUN echo "http://mirror.leaseweb.com/alpine/v3.3/main" | tee /etc/apk/repositories

RUN apk update && \
    apk upgrade --update && \
    apk add build-base curl vim && \
    cd /opt && \
    curl -LS "http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -o apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar xvzf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
    rm /opt/apache-maven-$MAVEN_VERSION-bin.tar.gz

WORKDIR /opt/rocksaw

CMD ["mvn", "clean", "test"]
