FROM ubuntu:16.04
MAINTAINER Toshiaki Baba <toshiaki@netmark.jp>

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

RUN sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt-get -y update \
    && apt-get -y install \
        language-pack-ja-base \
        language-pack-ja \
    && apt-get clean

RUN apt-get -y update \
        && apt-get -y install \
            texlive \
            texlive-lang-cjk \
            xdvik-ja \
            dvipsk-ja \
            gv \
            texlive-fonts-recommended \
            texlive-fonts-extra \
        && apt-get clean
RUN apt-get -y update \
        && apt-get -y install \
            make \
            python-pip \
        && apt-get clean
RUN pip install Sphinx==1.4.8

VOLUME ["/mnt"]
WORKDIR /mnt
