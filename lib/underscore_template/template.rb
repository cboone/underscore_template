require 'sprockets'
require 'sprockets/engines'
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
      <<-TMPL
(function($) {
  _.templates#{template_names(scope)} = _.template("#{escape_javascript data}");
})();
      TMPL
    end

    private

    def template_names(scope)
      nest_names(extract_names(scope.logical_path))
    end

    def nest_names(names)
      "['#{names.join("']['")}']"
    end

    def extract_names(path)
      match_names(path).
          split('/').
          map { |name| name.camelize(:lower) }
    end

    def match_names(path)
      names = path.match(/\A templates \/ (.+) \. .+ \Z/xi)
      (names && names.length > 0) ? names[1] : name
    end
  end

  Sprockets.register_engine '._html', ::UnderscoreTemplate::Template
end
