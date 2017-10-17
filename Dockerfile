# use a node base image
FROM node:7-onbuild

# set maintainer
LABEL maintainer "miiro@getintodevops.com"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

ARG DOCKER_GID=993

RUN groupadd -g ${DOCKER_GID} docker \
  && curl -sSL https://get.docker.com/ | sh \
  && apt-get -q autoremove \
  && apt-get -q clean -y \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin 

RUN useradd -m -d /home/jenkins -s /bin/sh jenkins \
  && usermod -aG docker jenkins
  
# tell docker what port to expose
EXPOSE 8000
