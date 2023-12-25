source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'httparty'
gem 'mysql2', '>= 0.4.4'
gem 'psych', '< 4'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.6', '>= 6.0.6.1'
gem 'rufus-scheduler'
gem 'trailblazer-rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rswag'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'timecop', '~> 0.9.8'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'vcr'
  gem 'webmock'
end

