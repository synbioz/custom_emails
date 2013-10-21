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
        context = options[:context] || {}
        sender  = options[:from]    || CustomEmails.default_from
        subject = email.interpolated_subject(context)

        mail(to: dest, from: sender, subject: subject) do |format|
          format.html { email.interpolated_content_html(context) } if email.content_html.present?
          format.text { email.interpolated_content_text(context) }
        end
      end
    end
  end
end
