class CreateCustomEmailsEmails < ActiveRecord::Migration
  def change
    create_table :custom_emails_emails do |t|
      t.integer :emailable_id
      t.string  :emailable_type
      t.string  :locale
      t.text    :subject
      t.text    :content_text
      t.text    :content_html

      t.timestamps
    end

    add_index :custom_emails_emails, :locale
    add_index :custom_emails_emails, :emailable_id
  end
end
