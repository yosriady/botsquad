class AddStatusToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :status, :integer, null: false, default: 0
  end
end
