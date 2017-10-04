require_relative 'boot'
require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hyrule
  class Application < Rails::Application
    config.force_ssl = true
    #config email preview routes
    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :fr
    #Use Rspec to generate starter file for application test suite
    #everydayrails.com rspec tutorial
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures         => true, #generate fixture for each model
        :view_specs       => false, #skip generating view specs
        :helper_specs     => false, #skip generating helper files
        :routing_specs    => false, #skip generating helper for routes, TODOlater ?
        :controller_specs => true,
        :request_specs    => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories" #generate factory instead of default fixtures
    end
  end

end
