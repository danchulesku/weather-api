require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeatherApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    if %w[development test].include? ENV['RAILS_ENV']
      Dotenv::Railtie.load
    end

    config.city_code = '294021'
    config.foreign_weather_api_domain = 'http://dataservice.accuweather.com'
    config.foreign_weather_api_key = ENV['API_KEY']
    config.active_job.queue_adapter = :delayed_job

    config.redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
    config.cache_store = :redis_cache_store, { url: config.redis_url }
    config.session_store :redis_store, servers: "#{config.redis_url}/session", expire_after: 90.minutes
    redis = Redis.new(url: config.redis_url)
    redis.flushdb
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
