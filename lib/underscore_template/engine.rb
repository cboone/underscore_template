require 'rails/engine'
require 'active_support/ordered_options'

module UnderscoreTemplate
  class Engine < ::Rails::Engine
    config.before_initialize do |app|
      Sprockets.register_engine '._html', UnderscoreTemplate::Template
    end
  end
end
