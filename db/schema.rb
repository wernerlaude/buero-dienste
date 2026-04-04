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

ActiveRecord::Schema[8.1].define(version: 2026_04_04_144420) do
  create_table "access_tokens", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "token"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["token"], name: "index_access_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "action_text_rich_texts", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.text "body", size: :long
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blog_posts", id: :integer, charset: "utf8mb3", collation: "utf8mb3_bin", force: :cascade do |t|
    t.string "bildnachweis"
    t.text "content"
    t.integer "count"
    t.datetime "created_at", precision: nil
    t.integer "lesezeit", default: 1
    t.string "list_title"
    t.string "meta_desc"
    t.string "meta_title"
    t.boolean "online"
    t.integer "ratings_count"
    t.string "subtitle"
    t.string "target_url"
    t.text "teaser"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.string "verweis"
  end

  create_table "bundeslands", id: :integer, charset: "utf8mb3", collation: "utf8mb3_bin", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "info"
    t.string "name"
    t.datetime "updated_at", precision: nil
  end

  create_table "links", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.text "beschreibung"
    t.string "bezeichner"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "online"
    t.integer "position"
    t.string "target_url"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "offers", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "card_image"
    t.string "card_title", null: false
    t.integer "category"
    t.integer "count"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "header_subtitle"
    t.string "header_title"
    t.string "ident", null: false
    t.string "image"
    t.text "keywords"
    t.string "meta_desc"
    t.boolean "online"
    t.integer "position"
    t.integer "search_priority", default: 1
    t.text "short_desc"
    t.string "slug"
    t.string "subtitle"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["keywords"], name: "fulltext_keywords", type: :fulltext
    t.index ["search_priority"], name: "index_offers_on_search_priority"
  end

  create_table "offers_users", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "user_id"
    t.index ["offer_id"], name: "index_offers_users_on_offer_id"
    t.index ["user_id"], name: "index_offers_users_on_user_id"
  end

  create_table "page_views", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "page_name"
    t.datetime "updated_at", null: false
    t.datetime "viewed_at"
  end

  create_table "tags", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.string "verweis"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "anrede"
    t.string "berufsbezeichnung"
    t.text "beschreibung"
    t.datetime "booked_at"
    t.integer "bundesland_id"
    t.boolean "copyright"
    t.integer "count", default: 0
    t.datetime "created_at", null: false
    t.boolean "datenschutz"
    t.string "email", default: "", null: false
    t.boolean "erstberatung"
    t.string "firmenmotto"
    t.string "firmenname"
    t.string "gesellschaftsform"
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.boolean "maps", default: false
    t.string "meta_desc"
    t.string "meta_title"
    t.string "mobile"
    t.string "nachname"
    t.boolean "online", default: false, null: false
    t.string "ort"
    t.string "other_offers"
    t.string "otp_secret"
    t.string "plz"
    t.boolean "premium", default: false, null: false
    t.decimal "price", precision: 8, scale: 2
    t.string "qualifikation"
    t.text "references"
    t.string "strasse"
    t.string "telefon"
    t.datetime "updated_at", null: false
    t.date "vertragsbegin"
    t.string "vorname"
    t.string "webpage"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "zip_coordinates", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.float "latitude"
    t.string "loc_id"
    t.float "longitude"
    t.string "ort"
    t.string "plz"
    t.datetime "updated_at", null: false
  end
end
