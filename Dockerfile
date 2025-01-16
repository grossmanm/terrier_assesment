FROM ruby:3.4.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client

# Set working directory
WORKDIR /app

# Install Rails and Bundler
RUN gem install rails bundler

# Copy Gemfile and install gems
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copy the rest of the application code
COPY . /app

# Expose port
EXPOSE 3000

