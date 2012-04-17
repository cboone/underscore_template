require 'rails/engine'
require 'active_support/ordered_options'

module UnderscoreTemplate
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.config.assets.underscore_template = ::ActiveSupport::OrderedOptions.new
      app.config.assets.underscore_template.namespace = '_'
    end
  end
end
