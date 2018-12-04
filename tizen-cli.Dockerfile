FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        --no-install-recommends \
        acl \
        bridge-utils \
        ca-certificates \
        cpio \
        gettext \
        libcanberra-gtk-module \
        libcurl3-gnutls \
        libsdl1.2debian \
        libwebkitgtk-1.0-0 \
        libv4l-0 \
        libvirt-bin \
        libxcb-render-util0 \
        libxcb-randr0 \
        libxcb-shape0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxtst6 \
        make \
        openvpn \
        pciutils \
        python2.7 \
        qemu-kvm \
        rpm2cpio \
        sudo \
        zenity \
        zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install --yes curl
RUN touch /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb http://deb.nodesource.com/node_8.x xenial main' >> /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src http://deb.nodesource.com/node_8.x xenial main' >> /etc/apt/sources.list.d/nodesource.list
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | sudo bash -
RUN apt-get update
RUN apt-cache policy nodejs
RUN apt-get install --yes nodejs
RUN apt-get install --yes build-essential
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
RUN node --version

RUN apt-get update
RUN apt-get install --yes apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install --yes yarn



RUN  apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

RUN useradd -m -G sudo,kvm,libvirtd tizen && \
    passwd -d tizen

USER tizen
WORKDIR /home/tizen
ENV BASH_ENV /home/tizen/.profile
SHELL ["/bin/bash", "-c"]

COPY --chown=tizen _deps/web-cli_Tizen_Studio_3.0_ubuntu-64.bin .
RUN chmod +x web-cli_Tizen_Studio_3.0_ubuntu-64.bin
RUN ./web-cli_Tizen_Studio_3.0_ubuntu-64.bin \
    --accept-license \
    ~/tizen-studio && \
    echo 'export PATH=$PATH:$HOME/tizen-studio/tools/ide/bin' >> ~/.profile && \
    rm web-cli_Tizen_Studio_3.0_ubuntu-64.bin

CMD ["/bin/bash", "--login"]
