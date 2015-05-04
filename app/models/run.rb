class Run < ActiveRecord::Base
  belongs_to :agent
  has_many :events

  enum status: %w( queued successful failed )
end
