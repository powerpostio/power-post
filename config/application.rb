require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PowerPost
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end

    config.time_zone = 'Brasilia'

    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :'pt-BR'
    config.i18n.locale = :'pt-BR'
    
    #config.i18n.default_locale = :'en'
    #config.i18n.locale = :'en'

    # Load the environment variables
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'variables.yml')

      YAML.load(File.open(env_file))[Rails.env].each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
