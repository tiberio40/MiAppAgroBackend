FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
#RUN apt-get install imagemagick
WORKDIR /miAppAgro
COPY Gemfile /miAppAgro/Gemfile
COPY Gemfile.lock /miAppAgro/Gemfile.lock   
#RUN gem install rails -v 6.1.4.1
RUN bundle install


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]