require 'custom_emails/engine'

module CustomEmails
  @@scoped         = true
  @@scoped_sms     = true
  @@default_locale = :en

  mattr_accessor :default_locale
  mattr_accessor :default_from
  mattr_accessor :scoped
  mattr_accessor :scoped_sms

  autoload :Models, 'custom_emails/models'
  autoload :Templatable, 'custom_emails/templatable'
end
