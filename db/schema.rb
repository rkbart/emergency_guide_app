ActiveRecord::Schema[8.0].define(version: 2025_05_24_035345) do
  enable_extension "pg_catalog.plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "checklists", force: :cascade do |t|
    t.string "items"
    t.string "description"
    t.boolean "checked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_checklists_on_user_id"
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "agency_name"
    t.string "phone_number"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false, null: false
    t.index ["user_id"], name: "index_emergency_contacts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category"
    t.string "title"
    t.string "description"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "symptoms"
    t.text "treatment"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_topics_on_category_id"
  end

  add_foreign_key "checklists", "users"
  add_foreign_key "emergency_contacts", "users"
  add_foreign_key "topics", "categories"
end
