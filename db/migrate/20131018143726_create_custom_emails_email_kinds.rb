class CreateCustomEmailsEmailKinds < ActiveRecord::Migration
  def change
    create_table :custom_emails_email_kinds do |t|
      t.string :name

      t.timestamps
    end

    add_index :custom_emails_email_kinds, :name, unique: true

    add_column :custom_emails_emails, :kind_id, :integer
    add_index :custom_emails_emails, [:kind_id, :emailable_id]

    # The uniqueness of the (kind, locale, emailable) tuple is ensured here
    add_index :custom_emails_emails, [:kind_id, :locale, :emailable_id, :emailable_type], unique: true, name: 'unique_w_kind_locale_and_emailable'
  end
end
