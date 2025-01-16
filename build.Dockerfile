# Use official Ruby image
FROM ruby:3.4.1

# Set working directory inside the container
WORKDIR /app

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application files
COPY . .

# Expose port 3000 for Rails server
EXPOSE 3000

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
