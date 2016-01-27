FROM ubuntu:14.04 

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="Vault" org.kurron.ide.version=0.4.0

ADD https://releases.hashicorp.com/vault/0.4.0/vault_0.4.0_linux_amd64.zip /tmp/ide.zip 

RUN apt-get update && \
    apt-get install -y unzip ca-certificates && \
    unzip /tmp/ide.zip -d /usr/local/bin && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN chmod 0555 /usr/local/bin/*

# Create a user and group that matches what is in most Vagrant boxes
RUN groupadd --gid 1000 developer && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash developer && \
    chown -R developer:developer /home/developer

# the user of this image is expected to mount his actual home directory to this one
VOLUME ["/home/developer"]
VOLUME ["/pwd"]

ENV HOME /home/developer
WORKDIR /pwd
ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["--version"]
