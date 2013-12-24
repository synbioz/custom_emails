# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131224105500) do

  create_table "custom_emails_email_kinds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_emails_email_kinds", ["name"], name: "index_custom_emails_email_kinds_on_name", unique: true

  create_table "custom_emails_emails", force: true do |t|
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.string   "locale"
    t.text     "subject"
    t.text     "content_text"
    t.text     "content_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind_id"
  end

  add_index "custom_emails_emails", ["emailable_id"], name: "index_custom_emails_emails_on_emailable_id"
  add_index "custom_emails_emails", ["kind_id", "emailable_id"], name: "index_custom_emails_emails_on_kind_id_and_emailable_id"
  add_index "custom_emails_emails", ["kind_id", "locale", "emailable_id", "emailable_type"], name: "unique_w_kind_locale_and_emailable", unique: true
  add_index "custom_emails_emails", ["locale"], name: "index_custom_emails_emails_on_locale"

  create_table "custom_emails_short_message_kinds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_emails_short_message_kinds", ["name"], name: "index_custom_emails_short_message_kinds_on_name", unique: true

  create_table "custom_emails_short_messages", force: true do |t|
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.integer  "kind_id"
    t.string   "locale"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_emails_short_messages", ["kind_id", "locale", "messageable_id", "messageable_type"], name: "unique_w_kind_locale_and_messageable", unique: true
  add_index "custom_emails_short_messages", ["kind_id", "messageable_id"], name: "index_w_kind_and_messageable"
  add_index "custom_emails_short_messages", ["locale"], name: "index_custom_emails_short_messages_on_locale"
  add_index "custom_emails_short_messages", ["messageable_id"], name: "index_custom_emails_short_messages_on_messageable_id"

  create_table "examples", force: true do |t|
  end

end
