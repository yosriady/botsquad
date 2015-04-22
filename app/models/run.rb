class Run < ActiveRecord::Base
  obfuscate_id
  belongs_to :agent

  enum status: %w( inprogress successful failed )
end
