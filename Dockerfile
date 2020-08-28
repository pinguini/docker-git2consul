FROM node:lts
MAINTAINER Mokin Anton <https://github.com/pinguini>

RUN apt-get update && apt-get install -y git openssh && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,lists,cache,log}/
    npm install git2consul@0.12.10 --global && \
    mkdir -p /etc/git2consul.d

ADD config.json /etc/git2consul.d/config.json
ADD init.sh /init.sh
RUN chmod 700 /init.sh

ENTRYPOINT [ "/init.sh" ]
