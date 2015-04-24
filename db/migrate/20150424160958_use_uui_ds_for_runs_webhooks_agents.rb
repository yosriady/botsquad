class UseUuiDsForRunsWebhooksAgents < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    drop_table "webhooks"
    create_table "webhooks", force: :cascade, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.integer  "status",     default: 0, null: false
      t.integer  "agent_id",               null: false
      t.string   "url"
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    drop_table "runs"
    create_table "runs", force: :cascade, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.integer  "status",     default: 0, null: false
      t.integer  "agent_id",               null: false
      t.json     "response"
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    drop_table "events"
    create_table "events", force: :cascade, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid     "run_id",                 null: false
      t.integer  "status",     default: 0, null: false
      t.uuid     "webhook_id",             null: false
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

  end
end
