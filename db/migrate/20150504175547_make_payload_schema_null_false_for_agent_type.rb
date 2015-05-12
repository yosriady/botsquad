class MakePayloadSchemaNullFalseForAgentType < ActiveRecord::Migration
  def change
    change_column :agent_types, :payload_schema, :json, null: false
  end
end
