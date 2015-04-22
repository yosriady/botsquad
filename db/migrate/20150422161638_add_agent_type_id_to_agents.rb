class AddAgentTypeIdToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :agent_type_id, :integer, null: false
    remove_column :agents, :type, :integer, null: false
  end
end
