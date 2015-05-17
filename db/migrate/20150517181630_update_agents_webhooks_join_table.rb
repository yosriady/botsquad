class UpdateAgentsWebhooksJoinTable < ActiveRecord::Migration
  def change
    remove_column :agents_webhooks, :agent_id, :integer
    add_column :agents_webhooks, :agent_id, :uuid
  end
end
