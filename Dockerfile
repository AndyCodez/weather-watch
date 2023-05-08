FROM ruby:3.1.3

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    postgresql-client \
    yarn \
    git

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Set entrypoint
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"] 
