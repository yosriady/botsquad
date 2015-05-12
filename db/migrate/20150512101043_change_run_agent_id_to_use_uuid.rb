class ChangeRunAgentIdToUseUuid < ActiveRecord::Migration
  def change
    remove_column :runs, :agent_id, :integer, null: false
    add_column :runs, :agent_id, :uuid, null: false
  end
end
