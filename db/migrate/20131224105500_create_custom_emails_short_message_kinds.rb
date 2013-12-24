class CreateCustomEmailsShortMessageKinds < ActiveRecord::Migration
  def change
    create_table :custom_emails_short_message_kinds do |t|
      t.string :name

      t.timestamps
    end

    add_index :custom_emails_short_message_kinds, :name, unique: true
  end
end
