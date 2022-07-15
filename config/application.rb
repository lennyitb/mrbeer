require_relative "boot"

require "rails/all"
# require "#{Rails.root}/lib/persistant.rb"
# require_relative "lib/persistant.rb"

# config.autoload_paths += %W(#{config.root}/lib)
# config.autoload_paths += Dir["#{config.root}/lib/**/"]

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mrbeer
  class Application < Rails::Application
    # include Persistant
    # PersistantObj.persistantpath = 'persistant'
    # $beerprice = PersistantObj.new name: 'beerprice', input_filter: /^\d{1,4}(\.\d{1,2})?$/, output_format: "%0.2f"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # $beerprice = nil
  end
end
