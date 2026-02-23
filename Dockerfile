FROM debian:bookworm AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential libcurl4-gnutls-dev libexpat1-dev zlib1g-dev libssl-dev gettext ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY . /tmp/git-src
RUN cd /tmp/git-src && make clean \
    && make -j$(nproc) NO_TCLTK=YesPlease prefix=/usr DESTDIR=/tmp/git-install \
    && make NO_TCLTK=YesPlease prefix=/usr DESTDIR=/tmp/git-install install

FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends git=1:2.39.5-0+deb12u3 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/git-install/usr/ /usr/
