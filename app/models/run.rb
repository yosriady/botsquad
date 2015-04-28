class Run < ActiveRecord::Base
  obfuscate_id
  belongs_to :agent
  has_many :events

  enum status: %w( queued successful failed )
end
