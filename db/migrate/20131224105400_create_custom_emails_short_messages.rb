class CreateCustomEmailsShortMessages < ActiveRecord::Migration
  def change
    create_table :custom_emails_short_messages do |t|
      t.integer :messageable_id
      t.string  :messageable_type
      t.integer :kind_id
      t.string  :locale
      t.text    :content

      t.timestamps
    end

    add_index :custom_emails_short_messages, :locale
    add_index :custom_emails_short_messages, :messageable_id
    add_index :custom_emails_short_messages, [:kind_id, :messageable_id], name: 'index_w_kind_and_messageable'

    # The uniqueness of the (kind, locale, messageable) tuple is ensured here
    add_index :custom_emails_short_messages, [:kind_id, :locale, :messageable_id, :messageable_type], unique: true, name: 'unique_w_kind_locale_and_messageable'
  end
end
