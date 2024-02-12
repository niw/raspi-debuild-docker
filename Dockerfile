FROM debian:bookworm

RUN sed -i -- 's/Types: deb/Types: deb deb-src/g' /etc/apt/sources.list.d/debian.sources

RUN apt update \
    && apt install -y --no-install-recommends \
        build-essential \
        devscripts \
        fakeroot \
        quilt \
        vim

COPY raspi.list /etc/apt/sources.list.d/
COPY raspberrypi-archive-keyring_2021.1.1+rpt1_all.deb /tmp/
RUN cd /tmp \
    && dpkg -i raspberrypi-archive-keyring_2021.1.1+rpt1_all.deb \
    && apt update

RUN mkdir -p workdir

RUN apt clean \
    && rm -rf /tmp/* /var/tmp/*

VOLUME /host

VOLUME /workdir
WORKDIR /workdir
