class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name, null: false
      t.integer :interval, default: 0, null: false
      t.integer :type, default: 0, null: false
      t.integer :user_id
      t.json :payload
      t.string :description

      t.timestamps null: false
    end
  end
end
