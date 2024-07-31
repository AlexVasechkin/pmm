FROM debian:12

WORKDIR /root

COPY ./percona-release_latest.generic_all.deb ./percona-release_latest.generic_all.deb

RUN apt update -y && \
    apt install -y wget lsb-release curl gnupg2 && \
    dpkg -i percona-release_latest.generic_all.deb && \
    apt update -y && \
    apt install -y pmm2-client

COPY ./pmm-config.yaml /root/pmm-config.yaml
