require 'rails/engine'
require 'active_support/ordered_options'

module UnderscoreTemplate
  class Engine < ::Rails::Engine
    config.underscore_template = ::ActiveSupport::OrderedOptions.new
  end
end
