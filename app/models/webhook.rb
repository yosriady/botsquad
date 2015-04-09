class Webhook < ActiveRecord::Base
  belongs_to :user

  enum status: %w( active disabled )
end
