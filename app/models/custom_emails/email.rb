module CustomEmails
  class Email < ActiveRecord::Base
    if CustomEmails.scoped
      belongs_to :emailable, polymorphic: true
    end

    belongs_to :kind, class_name: EmailKind, inverse_of: :emails

    validates_presence_of :locale, :subject, :content_text, :kind

    def to(dest, options={})
      CustomEmails::Mailer.email_to(self, dest, options)
    end
  end
end
