require 'test_helper'

class MailerTest < ActionMailer::TestCase
  def setup
    # Empty deliveries
    ActionMailer::Base.deliveries = []
    @sender_email = 'sender@example.org'
    CustomEmails.default_from = @sender_email
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end

  test 'email interpolated attributes are used when custom_email_to is called' do
    kind  = CustomEmails::EmailKind.create(name: :kind_1)
    email = CustomEmails::Email.create(kind: kind, locale: :en, subject: 'Hello {{ name }}!', content_text: 'Good luck {{ name }}...')
    mail  = CustomEmails::Mailer.custom_email_to('test@example.com', :kind_1, nil, context: {'name' => 'Luc'})
    mail.deliver

    assert(last_email.subject == 'Hello Luc!')
    assert(last_email.body == 'Good luck Luc...')
    assert(last_email.from.include?(@sender_email))
    assert(last_email.to.include?('test@example.com'))
  end

  test 'custom_email_to raises an exception if there is no matching email' do
    kind = nil

    # Missing kind
    assert_raises(ActiveRecord::RecordNotFound) do
      CustomEmails::Mailer.custom_email_to('test@example.com', :kind_1)
    end

    # No emails of this kind
    assert_raises(ActiveRecord::RecordNotFound) do
      kind = CustomEmails::EmailKind.create(name: :kind_1)
      CustomEmails::Mailer.custom_email_to('test@example.com', :kind_1)
    end

    # Wrong locale
    assert_raises(ActiveRecord::RecordNotFound) do
      email = CustomEmails::Email.create(kind: kind, locale: :fr, subject: 'Hello world!', content_text: 'Good luck...')
      CustomEmails::Mailer.custom_email_to('test@example.com', :kind_1)
    end
  end
end
