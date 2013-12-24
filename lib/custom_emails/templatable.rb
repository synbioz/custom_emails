require 'active_support/concern'
require 'liquid'

module CustomEmails
  module Templatable
    extend ActiveSupport::Concern

    module ClassMethods
      # Checks if a content is valid for interpolation.
      #
      # @return [Boolean]
      def valid_template?(content)
        return true if content.blank?

        template = ::Liquid::Template.parse(content)
        template.errors.empty?
      end

      # Use liquid to get the result of template interpretation.
      #
      # @param [String] the template
      # @param [Hash] the variable tree that have to be inserted into the template
      # @retrun [String]
      def interpolate(content, context)
        template = ::Liquid::Template.parse(content)
        if template.errors.empty?
          template.render(context)
        else
          content
        end
      end
    end
  end
end
