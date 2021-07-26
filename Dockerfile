FROM ubuntu:16.04

ENV TOR_VERSION="tor-0.4.6.6"
ENV MKP224O_VERSION="v1.5.0"

# Install base packages
RUN apt-get update
RUN apt-get -y install \            
    nginx \
    wget \
    git \
    ntpdate \
    build-essential automake libevent-dev libssl-dev zlib1g-dev \
    gcc libsodium-dev make autoconf


# NGINX
# Configure nginx logs to go to Docker log collection (via stdout/stderr)
RUN ln --symbolic --force /dev/stdout /var/log/nginx/access.log
RUN ln --symbolic --force /dev/stderr /var/log/nginx/error.log

# Security and permissions
RUN useradd --system --uid 666 -M --shell /usr/sbin/nologin hidden

# Add nginx default configuration 
ADD ./nginx.conf /etc/nginx/nginx.conf


# TOR
# Install TOR from source
RUN git clone https://git.torproject.org/tor.git --branch $TOR_VERSION /tor
WORKDIR /tor
RUN ./autogen.sh
RUN ./configure --disable-asciidoc
RUN make
RUN make install

# Add TOR config
ADD ./torrc /etc/tor/torrc

# Clone mkp224o, a vanity onion address generator
RUN git clone https://github.com/cathugger/mkp224o.git --branch $MKP224O_VERSION /mkp224o
WORKDIR /mkp224o
RUN ./autogen.sh
RUN ./configure
RUN make
RUN cp mkp224o /usr/local/bin/


# Configuration files and data output folder
RUN mkdir /web
RUN chmod 700 /web
VOLUME /web
WORKDIR /web


# Main script
ADD ./main /main
ENTRYPOINT ["/main"]
CMD ["serve"]
