FROM ruby:2.2.0

EXPOSE 80

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install -y openssl nodejs libgmp-dev libqt4-webkit libqt4-dev libxml2-dev ruby-json libxslt1-dev libpq-dev build-essential && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app

ENV RAILS_ENV production

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN bundle install

ADD *bower* $APP_HOME/

RUN npm install -g bower coffeescript && bower install --allow-root

ADD . $APP_HOME

CMD bash -c 'export SECRET_KEY_BASE="$(openssl rand -hex 64)" && export SECRET_TOKEN="$(openssl rand -hex 64)" && bundle exec rackup -s Puma --host 0.0.0.0 --port 80'