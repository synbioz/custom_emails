module CustomEmails
  class ShortMessage < ActiveRecord::Base
    include Templatable

    if CustomEmails.scoped_sms
      belongs_to :messageable, polymorphic: true
    end

    belongs_to :kind, class_name: ShortMessageKind, inverse_of: :short_messages

    validates_presence_of :locale, :content, :kind
    validate :ensure_valid_templates

    # Create an interpolated version of some attributes
    %w(content).each do |attr|
      class_eval "def interpolated_#{attr}(context) ; self.class.interpolate(#{attr}, context) end"
    end

    private

      def ensure_valid_templates
        if content.present? && !self.class.valid_template?(content)
          errors.add(:content, 'errors are found in the content template')
        end
      end
  end
end
