class AddStringLimits < ActiveRecord::Migration
  def change
    change_column :agent_types, :name, :string, null: false, limit: 255
    change_column :agent_types, :slug, :string, null: false, limit: 255
    change_column :agents, :name, :string, null: false, limit: 255
  end
end
