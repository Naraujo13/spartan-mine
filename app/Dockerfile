FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /spartan-mine
WORKDIR /spartan-mine
COPY Gemfile /spartan-mine/Gemfile
COPY Gemfile.lock /spartan-mine/Gemfile.lock
RUN bundle install
COPY . /spartan-mine
