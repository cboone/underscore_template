require 'tilt'
require 'action_view'
require 'action_view/helpers'
require 'action_view/helpers/javascript_helper'
require 'active_support/core_ext/string/inflections'

module UnderscoreTemplate
  class Template < ::Tilt::Template
    include ActionView::Helpers::JavaScriptHelper

    def self.default_mime_type
      'application/javascript'
    end

    # Required to be present by Tilt::Template
    def prepare
    end

    def evaluate(scope, locals, &block)
      names = template_names(scope)
      js = "(function(namespace) {\n"

      (names.length - 1).times do |index|
        name = nest_names names[0..index]
        js << "\tnamespace#{name} = namespace#{name} || {};\n"
      end

      full_name = nest_names names
      template = escape_javascript data

      js << "\tnamespace#{full_name} = namespace#{full_name} || _.template(\"#{template}\", undefined, {variable: 'data'});\n"
      js << "})(#{namespace});"
    end

    private

    def nest_names(names)
      "['#{names.join("']['")}']"
    end

    def template_names(scope)
      extract_names scope.logical_path
    end

    def extract_names(path)
      match_names(path).
          split('/').
          map { |name| name.camelize(:lower) }
    end

    def match_names(path)
      names = path.match /\A (.+) \. .+ \Z/xi
      (names && names.length > 0) ? names[1] : path
    end

    def namespace
      ::Rails.application.config.underscore_template.namespace || '_'
    end
  end
end
