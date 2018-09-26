# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'require_all'
gem 'activesupport'
gem 'activemodel', require: 'active_model'
gem 'colorize'
gem 'em-websocket'

group :development, :test do
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-npm'
  gem 'capistrano-procfile'
end
