class AddSlugToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :slug, :string
    add_index :agents, :slug, unique: true
  end
end
