FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev
RUN apk add shared-mime-info
RUN apk add git

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --with development

COPY . .

LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

CMD puma -C config/puma.rb
