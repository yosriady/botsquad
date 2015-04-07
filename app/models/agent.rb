# Agents have singular jobs
class Agent < ActiveRecord::Base
  # belongs_to :user
  enum interval: %w( week day hour )
  enum type: %w( uptime screenshot )

  def execute
    # TODO: enqueue job
  end
end
