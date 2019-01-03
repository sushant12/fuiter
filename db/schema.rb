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

ActiveRecord::Schema.define(version: 2018_12_30_070956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "fb_page_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "properties"
    t.uuid "fb_page_id"
    t.uuid "template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fb_page_id"], name: "index_fb_page_templates_on_fb_page_id"
    t.index ["template_id"], name: "index_fb_page_templates_on_template_id"
  end

  create_table "fb_pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "token"
    t.jsonb "content"
    t.boolean "status", default: false
    t.string "sub_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "name"
    t.string "fb_page_id"
    t.index ["user_id"], name: "index_fb_pages_on_user_id"
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.jsonb "seo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "fb_page_template_id"
    t.index ["fb_page_template_id"], name: "index_pages_on_fb_page_template_id"
  end

  create_table "settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "socail_media"
    t.jsonb "legal_info"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "fb_page_template_id"
    t.index ["fb_page_template_id"], name: "index_settings_on_fb_page_template_id"
  end

# Could not dump table "subscriptions" because of following StandardError
#   Unknown type 'subscription_type' for column 'category'

  create_table "templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.jsonb "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'user_category' for column 'category'

  add_foreign_key "fb_page_templates", "fb_pages"
  add_foreign_key "fb_page_templates", "templates"
  add_foreign_key "fb_pages", "users"
  add_foreign_key "pages", "fb_page_templates"
  add_foreign_key "settings", "fb_page_templates"
  add_foreign_key "subscriptions", "fb_pages", column: "fb_pages_id"
end
