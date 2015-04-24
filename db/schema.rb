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

ActiveRecord::Schema.define(version: 20150424160958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "agent_types", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "description",                 null: false
    t.string   "slug",            limit: 255, null: false
    t.json     "sample_payload",              null: false
    t.json     "sample_response",             null: false
    t.string   "job_type",                    null: false
    t.string   "script_path",                 null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "agents", force: :cascade do |t|
    t.string   "name",          limit: 255,             null: false
    t.integer  "interval",                  default: 0, null: false
    t.integer  "user_id",                               null: false
    t.json     "payload"
    t.string   "description"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "slug"
    t.integer  "agent_type_id",                         null: false
  end

  add_index "agents", ["slug"], name: "index_agents_on_slug", unique: true, using: :btree

  create_table "events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "run_id",                 null: false
    t.integer  "status",     default: 0, null: false
    t.uuid     "webhook_id",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "runs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "status",     default: 0, null: false
    t.integer  "agent_id",               null: false
    t.json     "response"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "signups", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "api_key",                             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "webhooks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "status",     default: 0, null: false
    t.integer  "agent_id",               null: false
    t.string   "url"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
