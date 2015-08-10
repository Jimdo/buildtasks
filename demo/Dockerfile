FROM ruby:2.1

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        devscripts \
        equivs \
        git-buildpackage \
        git \
        golang-go \
        lsb-release \
        make \
        openssh-client \
        pristine-tar \
        rake \
        rsync \
        wget

RUN gem install fpm -v 1.3.3
RUN gem install fpm-cookery -v 0.25.0
RUN gem install buildtasks -v 0.0.1

# Required for Puppet 4.0.0.rc1 to work
RUN mkdir -p /etc/puppetlabs /opt/puppetlabs/puppet

ENV BUNDLE_JOBS 3
ENV BUNDLE_RETRY 3
