FROM jfairbairn/base

MAINTAINER James Fairbairn <james@netlagoon.com>

USER root
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential libssl-dev libpq-dev postgresql-client supervisor

USER app

RUN git clone https://github.com/sstephenson/rbenv.git ~app/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~app/.rbenv/plugins/ruby-build

ENV PATH $HOME/.rbenv/bin:$PATH

RUN echo $PATH

RUN eval "$(rbenv init -)"

USER root

RUN apt-get install -y libreadline-dev

USER app

RUN rbenv install 2.2.4

RUN rbenv global 2.2.4

RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile

RUN ["bash", "-lc", "gem install bundler --no-rdoc --no-ri"]

EXPOSE 3000
