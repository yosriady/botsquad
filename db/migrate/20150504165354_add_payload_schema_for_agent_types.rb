class AddPayloadSchemaForAgentTypes < ActiveRecord::Migration
  def change
    add_column :agent_types, :payload_schema, :json
  end
end
