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

ActiveRecord::Schema.define(version: 20180223003136) do

  create_table "collections", force: :cascade do |t|
    t.string   "collection_id", limit: 255
    t.integer  "museum_id",     limit: 4
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "collections", ["museum_id"], name: "fk_rails_08649142e7", using: :btree

  create_table "example_categories", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "example_post_tags", force: :cascade do |t|
    t.integer  "example_posts_id", limit: 4
    t.integer  "example_tags_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "example_post_tags", ["example_posts_id"], name: "index_example_post_tags_on_example_posts_id", using: :btree
  add_index "example_post_tags", ["example_tags_id"], name: "index_example_post_tags_on_example_tags_id", using: :btree

  create_table "example_posts", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.string   "description",         limit: 255
    t.text     "content",             limit: 65535
    t.date     "publish_at"
    t.boolean  "public",              limit: 1
    t.integer  "plus_one",            limit: 4
    t.string   "url_image",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "example_category_id", limit: 4
  end

  add_index "example_posts", ["example_category_id"], name: "index_example_posts_on_example_category_id", using: :btree

  create_table "example_tags", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.boolean  "active",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.string   "item_id",             limit: 255
    t.string   "name",                limit: 255
    t.integer  "collection_id",       limit: 4
    t.datetime "year"
    t.string   "status",              limit: 255
    t.float    "lenght",              limit: 24
    t.float    "height",              limit: 24
    t.float    "width",               limit: 24
    t.float    "thickness",           limit: 24
    t.datetime "aquisition_date"
    t.float    "outer_circumference", limit: 24
    t.float    "inner_circumference", limit: 24
    t.float    "weight",              limit: 24
    t.string   "conservation_state",  limit: 255
    t.string   "biography",           limit: 255
    t.string   "description",         limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "items", ["collection_id"], name: "fk_rails_3063064cfa", using: :btree

  create_table "museums", force: :cascade do |t|
    t.string   "cod_museum",    limit: 255
    t.string   "name",          limit: 255
    t.integer  "director_id",   limit: 4
    t.integer  "technician_id", limit: 4
    t.string   "address",       limit: 255
    t.string   "phone",         limit: 255
    t.string   "opening_hours", limit: 255
    t.string   "description",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "museums", ["director_id"], name: "fk_rails_e8e95c22c8", using: :btree
  add_index "museums", ["technician_id"], name: "fk_rails_813e63246a", using: :btree

  create_table "system_access_to_nested_resources", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "path",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_access_to_nested_resources", ["user_id"], name: "index_system_access_to_nested_resources_on_user_id", using: :btree

  create_table "system_access_tos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "program_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_access_tos", ["program_id"], name: "index_system_access_tos_on_program_id", using: :btree
  add_index "system_access_tos", ["user_id"], name: "index_system_access_tos_on_user_id", using: :btree

  create_table "system_bug_messages", force: :cascade do |t|
    t.text     "message",       limit: 65535
    t.boolean  "displayed",     limit: 1
    t.string   "message_from",  limit: 255
    t.string   "message_to",    limit: 255
    t.integer  "admin_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "system_bug_id", limit: 4
  end

  add_index "system_bug_messages", ["system_bug_id"], name: "index_system_bug_messages_on_system_bug_id", using: :btree

  create_table "system_bug_statuses", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_bugs", force: :cascade do |t|
    t.text     "problem",       limit: 65535
    t.integer  "bug_status_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_bugs", ["bug_status_id"], name: "index_system_bugs_on_bug_status_id", using: :btree

  create_table "system_category_programs", force: :cascade do |t|
    t.string   "locate_label", limit: 255
    t.string   "icon",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",  limit: 255
    t.integer  "position",     limit: 4,   default: 1, null: false
  end

  create_table "system_configs", force: :cascade do |t|
    t.string   "name_sort",                  limit: 255
    t.string   "name_company",               limit: 255
    t.string   "address_company",            limit: 255
    t.string   "country_company",            limit: 255
    t.string   "email_company",              limit: 255
    t.string   "phone_company",              limit: 255
    t.string   "terms_of_user_last_change",  limit: 255
    t.string   "privacity_last_change",      limit: 255
    t.string   "at_home_version_repository", limit: 255
    t.string   "google_maps_id",             limit: 255
    t.string   "google_analytics_id",        limit: 255
    t.string   "system_color",               limit: 255
    t.string   "system_color_disabled",      limit: 255
    t.string   "system_danger_color",        limit: 255
    t.string   "country_code",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_user",                 limit: 255, default: "email@athome.com", null: false
    t.string   "email_password",             limit: 255, default: "password",         null: false
  end

  create_table "system_files", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "original_name", limit: 255
    t.string   "path",          limit: 255
    t.string   "content_type",  limit: 255
    t.integer  "user_id",       limit: 4
    t.boolean  "public",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_files", ["user_id"], name: "index_system_files_on_user_id", using: :btree

  create_table "system_group_access_people", force: :cascade do |t|
    t.integer  "users_id",               limit: 4
    t.integer  "system_group_access_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_group_access_people", ["system_group_access_id"], name: "index_system_group_access_people_on_system_group_access_id", using: :btree
  add_index "system_group_access_people", ["users_id"], name: "index_system_group_access_people_on_users_id", using: :btree

  create_table "system_group_access_programs", force: :cascade do |t|
    t.integer  "system_group_accesses_id", limit: 4
    t.integer  "system_programs_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_group_access_programs", ["system_group_accesses_id"], name: "index_system_group_access_programs_on_system_group_accesses_id", using: :btree
  add_index "system_group_access_programs", ["system_programs_id"], name: "index_system_group_access_programs_on_system_programs_id", using: :btree

  create_table "system_group_accesses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "active",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_help_categories", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_helps", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "system_help_category_id", limit: 4
    t.string   "sort_description",        limit: 255
    t.integer  "like",                    limit: 4
    t.string   "type",                    limit: 255
    t.text     "post",                    limit: 65535
    t.integer  "viewed",                  limit: 4
    t.string   "link",                    limit: 255
    t.boolean  "featured",                limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_helps", ["system_help_category_id"], name: "index_system_helps_on_system_help_category_id", using: :btree

  create_table "system_programs", force: :cascade do |t|
    t.string   "locate_label",        limit: 255
    t.string   "description",         limit: 255
    t.string   "path",                limit: 255
    t.integer  "category_program_id", limit: 4
    t.string   "icon",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",             limit: 1,   default: true
    t.integer  "position",            limit: 4,   default: 1,    null: false
  end

  add_index "system_programs", ["category_program_id"], name: "index_system_programs_on_category_program_id", using: :btree

  create_table "system_vouchers", force: :cascade do |t|
    t.string   "voucher",      limit: 255
    t.datetime "dt_expire"
    t.string   "email",        limit: 255
    t.string   "pricing",      limit: 255
    t.string   "first_name",   limit: 255
    t.boolean  "voucher_used", limit: 1,   default: false, null: false
    t.integer  "user_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_vouchers", ["user_id"], name: "index_system_vouchers_on_user_id", using: :btree
  add_index "system_vouchers", ["voucher"], name: "index_system_vouchers_on_voucher", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",         null: false
    t.string   "encrypted_password",     limit: 255, default: "",         null: false
    t.string   "first_name",             limit: 255, default: "",         null: false
    t.string   "last_name",              limit: 255, default: "",         null: false
    t.boolean  "admin",                  limit: 1,   default: false,      null: false
    t.date     "born"
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",                 limit: 255
    t.string   "phone_number",           limit: 255
    t.string   "gender",                 limit: 255, default: "m",        null: false
    t.string   "address",                limit: 255, default: "",         null: false
    t.string   "postal_code",            limit: 255, default: "",         null: false
    t.string   "access_token",           limit: 255, default: "8a19e072", null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "collections", "museums", on_update: :cascade, on_delete: :cascade
  add_foreign_key "items", "collections", on_update: :cascade, on_delete: :cascade
  add_foreign_key "museums", "users", column: "director_id", on_update: :cascade
  add_foreign_key "museums", "users", column: "technician_id", on_update: :cascade
end
