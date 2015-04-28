class AddIndexToAgentsWebhooksTable < ActiveRecord::Migration
  def change
    add_index :agents_webhooks, [:webhook_id, :agent_id]
  end
end
