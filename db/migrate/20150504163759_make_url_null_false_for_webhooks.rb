class MakeUrlNullFalseForWebhooks < ActiveRecord::Migration
  def change
    change_column :webhooks, :url, :string, null: false
  end
end
