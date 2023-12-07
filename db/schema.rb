# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_02_25_200510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "name", null: false
    t.string "access_token", null: false
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "page"
    t.bigint "issue_id", null: false
    t.bigint "classification_id", null: false
    t.bigint "language_id"
    t.text "blurb"
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tag_ids", default: [], array: true
    t.integer "machine_ids", default: [], array: true
    t.boolean "regular_feature", default: false, null: false
    t.string "archive_page"
    t.index ["classification_id"], name: "index_articles_on_classification_id"
    t.index ["issue_id"], name: "index_articles_on_issue_id"
    t.index ["language_id"], name: "index_articles_on_language_id"
  end

  create_table "articles_machines", id: false, force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "machine_id", null: false
    t.index ["article_id", "machine_id"], name: "index_articles_machines_on_article_id_and_machine_id"
    t.index ["machine_id", "article_id"], name: "index_articles_machines_on_machine_id_and_article_id"
  end

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "tag_id", null: false
    t.index ["article_id", "tag_id"], name: "index_articles_tags_on_article_id_and_tag_id"
    t.index ["tag_id", "article_id"], name: "index_articles_tags_on_tag_id_and_article_id"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "magazine_id", null: false
    t.integer "year", null: false
    t.integer "month"
    t.integer "volume"
    t.integer "number"
    t.integer "sequence"
    t.string "special"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "special_slug"
    t.integer "archive_page_offset", default: 0, null: false
    t.index ["magazine_id"], name: "index_issues_on_magazine_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magazines", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "alpha_guide", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archive_suffix"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "alpha_guide", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "role_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "users", "roles"
end
