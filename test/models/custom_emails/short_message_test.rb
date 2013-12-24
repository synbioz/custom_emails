require 'test_helper'

module CustomEmails
  class ShortMessageTest < ActiveSupport::TestCase
    test "short message needs kind, locale and content to be valid" do
      kind  = ShortMessageKind.new(name: 'Friend notification')
      sms   = ShortMessage.new(kind: kind, locale: 'fr', content: 'Hello world!')
      assert sms.valid?

      sms.locale = nil
      refute sms.valid?
      sms.locale = 'fr'

      sms.kind = nil
      refute sms.valid?
      sms.kind = kind

      sms.content = nil
      refute sms.valid?
    end

    test "short message is scoped to an messageable model" do
      sms = ShortMessage.new
      assert sms.respond_to?(:messageable)
    end

    test "Short message has interpolation via liquid on content" do
      sms = ShortMessage.new(content: "Hello {{ firstname }}!")
      assert sms.respond_to?(:interpolated_content)

      context = {'firstname' => 'Nicolas'}
      assert sms.interpolated_content(context) == 'Hello Nicolas!'
    end
  end
end
