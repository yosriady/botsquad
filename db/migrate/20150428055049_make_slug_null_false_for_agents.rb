class MakeSlugNullFalseForAgents < ActiveRecord::Migration
  def change
    change_column :agents, :slug, :string, null: false
  end
end
