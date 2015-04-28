class MakeNameOptionalForAgents < ActiveRecord::Migration
  def change
    change_column :agents, :name, :string, null: true
  end
end
