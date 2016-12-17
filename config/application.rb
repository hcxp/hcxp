require_relative 'boot'

require 'rails/all'
require 'sprockets/es6'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Hcxp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.cells.with_assets = [
      'nav_main_cell', 'event_card_cell', 'venue_card_cell', 'blankslate_cell'
    ]

    # URL options
    config.action_controller.default_url_options = {
      host: ENV['APP_HOST']
    }

    config.action_mailer.default_url_options = {
      host: ENV['APP_HOST']
    }
  end
end
