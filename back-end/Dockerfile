FROM ruby:latest
MAINTAINER James Brady <james@teespring.com>

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

WORKDIR /app
COPY . /app
EXPOSE 3000
ENTRYPOINT rails server -b 0.0.0.0 -p 3000
