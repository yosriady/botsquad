class Webhook < ActiveRecord::Base
  belongs_to :agent

  enum status: %w( active disabled )
end
