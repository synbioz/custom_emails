require 'liquid'

module CustomEmails
  class Email < ActiveRecord::Base
    if CustomEmails.scoped
      belongs_to :emailable, polymorphic: true
    end

    belongs_to :kind, class_name: EmailKind, inverse_of: :emails

    validates_presence_of :locale, :subject, :content_text, :kind
    validate :ensure_valid_templates

    def to(dest, context={}, options={})
      options[:context] ||= context
      CustomEmails::Mailer.email_to(self, dest, options)
    end

    # Create an interpolated version of some attributes
    %w(subject content_text content_html).each do |attr|
      class_eval "def interpolated_#{attr}(context) ; interpolate(#{attr}, context) end"
    end

    # Checks if a content is valid for interpolation.
    #
    # @return [Boolean]
    def self.valid_template?(content)
      return true if content.blank?

      template = ::Liquid::Template.parse(content)
      template.errors.empty?
    end

    private

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

      def ensure_valid_templates
        if content_text.present? && !self.class.valid_template?(content_text)
          errors.add(:content_text, 'errors are found in the content_text template')
        end

        if content_html.present? && !self.class.valid_template?(content_html)
          errors.add(:content_html, 'errors are found in the content_html template')
        end
      end
  end
end
