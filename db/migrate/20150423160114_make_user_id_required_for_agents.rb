class MakeUserIdRequiredForAgents < ActiveRecord::Migration
  def change
    change_column :agents, :user_id, :integer, null: false
  end
end
