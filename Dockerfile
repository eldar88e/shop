FROM ruby:3.4.2-alpine3.21 AS miniapp

RUN apk --update add --no-cache \
    build-base \
    yaml-dev \
    tzdata \
    yarn \
    libc6-compat \
    postgresql-dev \
    postgresql-client \
    redis \
    curl \
    libffi-dev \
    ruby-dev \
    vips \
    vips-dev \
    && rm -rf /var/cache/apk/*

ENV BUNDLE_WITHOUT="development test"

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem update --system 3.6.6
RUN gem install bundler -v $(tail -n 1 Gemfile.lock)
RUN bundle check || bundle install
RUN bundle clean --force

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
# RUN rm -rf node_modules

COPY . .

RUN bundle exec rails assets:precompile

# RUN bundle exec bootsnap precompile app/ lib/
# ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000
