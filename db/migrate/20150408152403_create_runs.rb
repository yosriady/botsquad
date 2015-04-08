class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :status, null: false, default: 0
      t.integer :agent_id, null: false
      t.json :result

      t.timestamps null: false
    end
  end
end
