class CreateAgentTypes < ActiveRecord::Migration
  def change
    create_table :agent_types do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :slug
      t.json :payload_format, null: false
      t.json :result_format, null: false
      t.string :description, null: false
      t.string :job_type, null: false
      t.string :script_path, null: false

      t.timestamps null: false
    end
  end
end
