class AddWebhooksAgentsTable < ActiveRecord::Migration
  def change
    create_table :agents_webhooks, id: false do |t|
      t.uuid :webhook_id, index: true
      t.belongs_to :agent, index: true
    end
  end
  remove_column :webhooks, :agent_id, :integer, default: 0, null: false
end
