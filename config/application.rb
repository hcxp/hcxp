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

    I18n.available_locales = [:en, :pl]

    config.cells.with_assets = [
      'nav_main_cell', 'event_card_cell', 'venue_card_cell', 'blankslate_cell',
      'flash_messages_cell', 'language_picker_cell', 'post_card_cell', 'bands_list_cell'
    ]

    # Load additional locales
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # URL options
    config.action_controller.default_url_options = {
      host: ENV['APP_HOST']
    }

    config.action_mailer.default_url_options = {
      host: ENV['APP_HOST']
    }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      authentication: :plain,
      address:        ENV['MAIL_SERVER'] || 'localhost',
      user_name:      ENV['MAIL_LOGIN'] || nil,
      password:       ENV['MAIL_PASSWORD'] || nil,
      port:           ENV['MAIL_PORT'].to_i || 1025,
      domain:         ENV['APP_HOST']
    }
  end
end
