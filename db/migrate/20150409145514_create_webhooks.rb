class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.integer :status, default: 0, null: false
      t.integer :agent_id, null: false
      t.string :url

      t.timestamps null: false
    end
  end
end
