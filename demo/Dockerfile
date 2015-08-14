FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        devscripts \
        equivs \
        git-buildpackage \
        git \
        lsb-release \
        make \
        openssh-client \
        pristine-tar \
        rake \
        rsync \
        ruby \
        ruby-dev \
        rubygems \
        wget

RUN echo "gem: --no-ri --no-rdoc" >/etc/gemrc
RUN gem install fpm -v 1.4.0
RUN gem install fpm-cookery -v 0.29.0
RUN gem install buildtasks -v 0.0.1
RUN gem install bundler -v 1.10.0
