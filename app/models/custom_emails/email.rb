module CustomEmails
  class Email < ActiveRecord::Base
    include Templatable

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
      class_eval "def interpolated_#{attr}(context) ; self.class.interpolate(#{attr}, context) end"
    end

    private

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
