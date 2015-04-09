# Agents have singular jobs
class Agent < ActiveRecord::Base
  enum interval: %w( week day hour )
  enum type: %w( uptime screenshot )

  belongs_to :user
  has_many :runs
  has_many :webhooks

  def execute
    # TODO: enqueue job
  end
end
