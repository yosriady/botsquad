class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :run_id, null: false
      t.integer :status, default:0, null: false
      t.integer :webhook_id, null: false

      t.timestamps null: false
    end
  end
end
