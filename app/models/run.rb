class Run < ActiveRecord::Base
  belongs_to :agent

  enum status: %w( inprogress successful failed )
end
