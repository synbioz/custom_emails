# You can replace active_record with something else that is supported.
# This is the list of supported ORMs:
# - active_record
require 'custom_emails/orm/active_record'

# If emails are scoped to a certain model you should declare it with
# the `has_custom_emails` method and activate the association in the
# custom_emails with this option. (default: true)
#
# CustomEmails.scoped = false
