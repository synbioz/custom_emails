module CustomEmails
  module Models
    def has_custom_emails(options={})
      options = options.reverse_merge({
        as: :emails
      })

      has_many options[:as], as: :emailable, class_name: ::CustomEmails::Email, dependent: :destroy

      class_eval "def #{options[:as]}_by_kind(locale=nil)
          assoc = #{options[:as]}.includes(:kind)
          assoc = assoc.where(locale: locale) if locale
          assoc.group_by(&:kind)
        end"
    end

    def has_custom_short_messages(options={})
      options = options.reverse_merge({
        as: :short_messages
      })

      has_many options[:as], as: :messageable, class_name: ::CustomEmails::ShortMessage, dependent: :destroy

      class_eval "def #{options[:as]}_by_kind(locale=nil)
          assoc = #{options[:as]}.includes(:kind)
          assoc = assoc.where(locale: locale) if locale
          assoc.group_by(&:kind)
        end"
    end
  end
end
