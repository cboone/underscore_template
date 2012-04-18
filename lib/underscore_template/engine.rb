require 'rails/engine'
require 'active_support/ordered_options'

module UnderscoreTemplate
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.config.assets.underscore_template = ActiveSupport::OrderedOptions.new
    end

    config.before_initialize do |app|
      if app.config.assets.enabled
        Sprockets.register_engine '._html', UnderscoreTemplate::Template
      end
    end
  end
end
