FROM ruby:3.1.2

# dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN gem install bundler

# gems
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# copy app
COPY . /app

# start
CMD ["rails", "server", "-b", "0.0.0.0"]
