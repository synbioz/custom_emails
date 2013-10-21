require 'custom_emails/engine'

module CustomEmails
  @@scoped         = true
  @@default_locale = :en

  mattr_accessor :default_locale
  mattr_accessor :default_from
  mattr_accessor :scoped

  autoload :Models, 'custom_emails/models'
end
