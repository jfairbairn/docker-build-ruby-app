FROM jfairbairn/base

MAINTAINER James Fairbairn <james@netlagoon.com>

USER root
RUN apt-get install -y build-essential libssl-dev libpq-dev postgresql-client supervisor

USER app

RUN git clone https://github.com/sstephenson/rbenv.git ~app/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~app/.rbenv/plugins/ruby-build

ENV PATH $HOME/.rbenv/bin:$PATH

RUN echo $PATH

RUN eval "$(rbenv init -)"

USER app

RUN rbenv install 2.2.4

RUN rbenv global 2.2.4

RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile

RUN ["bash", "-lc", "gem install bundler --no-rdoc --no-ri"]

# build all the time-consuming native gems
RUN ["bash", "-lc", "gem install --no-rdoc --no-ri nokogiri:1.6.2.1 ffi:1.9.3 gherkin:2.12.2 eventmachine:1.0.3 pg:0.17.1 therubyracer:0.12.1"]

EXPOSE 3000
