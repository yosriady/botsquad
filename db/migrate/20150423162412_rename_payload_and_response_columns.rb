class RenamePayloadAndResponseColumns < ActiveRecord::Migration
  def change
    rename_column :agent_types, :payload_format, :sample_payload
    rename_column :agent_types, :result_format, :sample_response
    rename_column :runs, :result, :response
  end
end
