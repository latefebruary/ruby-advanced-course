FROM ruby:2.6.6

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN gem install bundler:2.1.4 && bundle install
EXPOSE 3000
CMD ["rackup"]
