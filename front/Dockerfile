FROM node:16.1.0-alpine

WORKDIR /app

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apk update && npm install -g @vue/cli