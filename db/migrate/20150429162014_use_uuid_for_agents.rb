class UseUuidForAgents < ActiveRecord::Migration
  def change
    drop_table "agents"
    create_table "agents", force: :cascade, id: :uuid, default: 'uuid_generate_v4()'   do |t|
      t.string   "name"
      t.integer  "interval",      default: 0, null: false
      t.integer  "user_id",                   null: false
      t.json     "payload",                   null: false
      t.string   "description"
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.string   "slug",                      null: false
      t.integer  "agent_type_id",             null: false
    end
  end
end
