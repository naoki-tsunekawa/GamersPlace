FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y \
		build-essential \
		libpq-dev \
    node.js \
    yarn \
		vim
ENV LANG C.UTF-8
WORKDIR /GamersPlace
COPY Gemfile Gemfile.lock /GamersPlace/
RUN bundle install
