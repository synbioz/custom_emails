require 'test_models'

class ModelsTest < ActiveSupport::TestCase
  def emailable
    Emailable.new
  end

  def same_hashes(h1, h2)
    h1.size == h2.size && h2.all?{ |k, v| h1[k].size == v.size && v.all?{ |e| h1[k].include?(e) } }
  end

  test "models using has_custom_emails ends with an :emails relation" do
    assert emailable.respond_to?(:emails)
  end

  test "models using has_custom_emails ends with an #emails_by_kind method" do
    assert emailable.respond_to?(:emails_by_kind)
  end

  test "the #emails_by_kind method returns an Hash" do
    assert emailable.emails_by_kind.kind_of?(Hash)
  end

  test "the #emails_by_kind method returns an Hash of emails grouped by kind" do
    e = emailable
    e.save

    kind_1  = CustomEmails::EmailKind.create(name: :kind_1)
    kind_2  = CustomEmails::EmailKind.create(name: :kind_2)
    email_1 = e.emails.create(kind: kind_1, locale: :en, subject: 'Fake subject', content_text: 'Fake body')
    email_2 = e.emails.create(kind: kind_2, locale: :en, subject: 'Fake subject 2', content_text: 'Fake body 2')

    subject = e.emails_by_kind
    expected_hash = {kind_1 => [email_1], kind_2 => [email_2]}

    assert same_hashes(expected_hash, subject)
  end

  test "the #emails_by_kind method accepts an optional argument to filter by locale" do
    e = emailable
    e.save

    kind_1  = CustomEmails::EmailKind.create(name: :kind_1)
    kind_2  = CustomEmails::EmailKind.create(name: :kind_2)
    email_1 = e.emails.create(kind: kind_1, locale: :en, subject: 'Fake subject', content_text: 'Fake body')
    email_2 = e.emails.create(kind: kind_2, locale: :fr, subject: 'Faux subjet 2', content_text: 'Faux corps 2')

    subject = e.emails_by_kind(:fr)
    expected_hash = {kind_2 => [email_2]}

    assert same_hashes(expected_hash, subject)
  end
end
