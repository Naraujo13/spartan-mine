FROM ruby:2.3.3
MAINTAINER Glauco Roberto Munsberg <glaucomunsberg@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-server mysql-client libmysqlclient-dev
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app