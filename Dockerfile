FROM teamcity-minimal-agent:latest

MAINTAINER Kateryna Shlyakhovetska <shkate@jetbrains.com>

LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

RUN apt-get install -y git mercurial oracle-java8-installer apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
RUN apt-cache policy docker-engine
RUN apt-get update
RUN apt-get install -y docker-engine=1.13.0-0~ubuntu-xenial
RUN apt-get clean all
RUN usermod -aG docker buildagent

COPY run-docker.sh /services/run-docker.sh


