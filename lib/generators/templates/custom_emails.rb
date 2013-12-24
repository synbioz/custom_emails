# You can replace active_record with something else that is supported.
# This is the list of supported ORMs:
# - active_record
require 'custom_emails/orm/active_record'

# If emails are scoped to a certain model you should declare it with
# the `has_custom_emails` method and activate the association in the
# custom_emails with this option. The default is true
#
#CustomEmails.scoped = false
#CustomEmails.scoped_sms = false

# You can customize the default sender of the custom emails here.
# This will be used by CustomEmails::Mailer#custom_email_to
#
CustomEmails.default_from = 'change-me@your-domain.com'

# This is the default locale used by CustomEmails::Mailer.custom_email_to
# the default is :en
#
#CustomEmails.default_locale = :en

