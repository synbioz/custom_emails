# CustomEmails

By [Synbioz](http://www.synbioz.com/)

## Description

This gem contains some basic models that allows the end-user of your applications to customize the application email.

## Example

This is a basic use case:

```ruby
target = 'foo@bar.org'
ctx = { 'name' => 'Luc' }

# Create default kinds
%w(request new_event).each do |kind_name|
  CustomEmails::EmailKind.find_or_create_by!(name: kind_name)
end

# Create an email
kind  = CustomEmails::EmailKind.find_by!(name: 'request')
email = CustomEmails::Email.create(
  locale:       :fr,
  kind:         kind,
  subject:      'Bonjour {{ name }} !',
  content_text: 'Bonne chance {{ name }}...'
)

# Send via the Email object
email.to(target, ctx).deliver

# Use the mailer to send an email if you don't have the Email objet
CustomEmails::Mailer.custom_email_to(target, 'request', nil, context: ctx).deliver
```

This is a basic use case with a scope object:

```ruby
# Declare a class with customizable emails
class Account
  ...
  has_custom_emails
  ...
end

acc = Account.first

# Create some email related to the account
email = account.emails.create(
  locale:       :fr,
  kind:         kind,
  subject:      'Bonjour {{ name }} !',
  content_text: 'Bonne chance {{ name }}...',
  content_html: '<b>Bonne change...</b>' # Optional
)

# Deliver the email to somebody
email.to(target, ctx).deliver

# Or do it direclty with the mailer
CustomEmails::Mailer.custom_email_to(target, 'request', acc, ctx).deliver
```

This scope object allows you to have multiple email per kind.

## Installation

Add this to your gemfile:

```ruby
gem 'custom_emails'
```

Add the tables to your database with:

```console
rake custom_emails:install:migrations
```

Add the initializer to configure the gem with:

```console
rails generate custom_emails:install
```

That's all!

## Limitations

- Only active record is supported

# Licence

This project uses the MIT licence.
