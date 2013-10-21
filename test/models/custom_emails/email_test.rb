require 'test_helper'

module CustomEmails
  class EmailTest < ActiveSupport::TestCase
    test "email needs kind, locale, subject and content_text to be valid" do
      kind  = EmailKind.new(name: 'Friend notification')
      email = Email.new(kind: kind, locale: 'fr', subject: 'dummy subject', content_text: 'Hello world!')
      assert email.valid?

      email.locale = nil
      refute email.valid?
      email.locale = 'fr'

      email.subject = nil
      refute email.valid?
      email.subject = 'dummy subject'

      email.kind = nil
      refute email.valid?
      email.kind = kind

      email.content_text = nil
      refute email.valid?
    end

    test "email is scoped to an emailable model" do
      email = Email.new
      assert email.respond_to?(:emailable)
    end

    test "email has a #to method that produces a Mail::Message" do
      CustomEmails.default_from = 'sender@example.org'

      email = Email.new
      assert email.respond_to?(:to)

      subject = email.to('foo@bar.org')
      assert subject.kind_of?(Mail::Message)
      assert subject.deliver
    end

    test "email has interpolation via liquid on subject, content_text and content_html" do
      CustomEmails.default_from = 'sender@example.org'

      email = Email.new
      assert email.respond_to?(:interpolated_subject)
      assert email.respond_to?(:interpolated_content_text)
      assert email.respond_to?(:interpolated_content_html)

      context = {'firstname' => 'Nicolas'}
      email.subject = 'Hello {{ firstname }}!'

      assert email.interpolated_subject(context) == 'Hello Nicolas!'
    end
  end
end
