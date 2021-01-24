FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Docker内部でworkdirをどこに置くか、どういう名前にするかを決める記述
RUN mkdir /workdir
WORKDIR /workdir

# Docker内部でGemfile、Gemfile.lockをどこに配置するかを決める記述
ADD Gemfile /workdir/Gemfile
ADD Gemfile.lock /workdir/Gemfile.lock

# Gemfile.lockにかいてあるbundlerバージョンが2.0.1以降だとエラーが出るため
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler -v 2.1.4
RUN bundle install

ADD . /workdir