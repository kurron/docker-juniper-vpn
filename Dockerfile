FROM ubuntu:14.04 

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="Juniper VPN" org.kurron.ide.version=0.0.0

ADD ncsvc /usr/local/bin/ncsvc
ADD cert /usr/local/bin/cert

RUN dpkg --add-architecture i386 && \
    apt-get update && \
#   apt-get install -y unzip ca-certificates libc6-i386 zlib1g lib32z1 lib32ncurses5 lib32bz2-1.0 libgtk2-perl libwww-perl && \
    apt-get install -y unzip ca-certificates libc6:i386 zlib1g:i386 lib32nss-mdns libstdc++6:i386 lib32z1 lib32ncurses5 lib32bz2-1.0 libxext6:i386 libxrender1:i386 libxtst6:i386 libxi6:i386 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN chmod 6711 /usr/local/bin/ncsvc
RUN chmod 0444 /usr/local/bin/cert

WORKDIR /usr/local/bin

ENTRYPOINT ["./ncsvc", "--log-level=5", "-h portal.transparent.com", "-U https://portal.transparent.com/mac", "-m fe9fefe1797891b183c35fd04a490bd0", "-f /usr/local/bin/cert", "-u ashkop", "-r Macintosh_Users", "-p 'bob'"]
