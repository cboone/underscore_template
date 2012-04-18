require 'rails/engine'
require 'active_support/ordered_options'

module UnderscoreTemplate
  class Engine < ::Rails::Engine
    config.underscore_template = ::ActiveSupport::OrderedOptions.new

    config.before_initialize do |app|
      if app.config.assets.enabled
        require 'sprockets'
        require 'sprockets/engines'

        Sprockets.register_engine '._html', ::UnderscoreTemplate::Template
      end
    end
  end
end
