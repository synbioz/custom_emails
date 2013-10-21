if defined?(ActionMailer)
  module CustomEmails
    class Mailer < ActionMailer::Base
      def custom_email_to(dest, kind_name, emailable=nil, options={})
        locale = options[:locale] || CustomEmails.default_locale
        kind   = EmailKind.find_by!(name: kind_name)
        email  = Email.find_by!(kind_id: kind.id, emailable_id: emailable.try(:id), locale: locale)

        email_to(email, dest, options)
      end

      def email_to(email, dest, options={})
        sender = options[:from] || CustomEmails.default_from

        mail(to: dest, from: sender, subject: email.subject) do |format|
          format.html { email.content_html } unless email.content_html.blank?
          format.text { email.content_text }
        end
      end
    end
  end
end
