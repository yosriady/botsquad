class Webhook < ActiveRecord::Base
  belongs_to :agent
  has_many :events

  enum status: %w( active disabled )
end
