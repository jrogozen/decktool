FROM ruby:2.7.0-alpine3.11

RUN apk add --no-cache --update \
  build-base \
  musl-dev \
  jpeg-dev \
  zlib-dev \
  libffi-dev \
  cairo-dev \
  cairo \
  cairo-tools \
  pango-dev \
  gdk-pixbuf-dev \
  gobject-introspection-dev \
  glib-dev \
  autoconf \
  automake \
  librsvg-dev \
  fontconfig

RUN rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

COPY fonts /usr/share/fonts
RUN fc-cache -f -v

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD bundle exec rackup config.ru --host 0.0.0.0 -p $PORT