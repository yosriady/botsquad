class AddAcceptRunsToWebhooks < ActiveRecord::Migration
  def change
    add_column :webhooks, :accept_runs, :integer, default: 0
  end
end
