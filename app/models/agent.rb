# Agents have singular jobs
class Agent < ActiveRecord::Base
  enum interval: %w( week day hour )
  enum type: %w( uptime screenshot )

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  belongs_to :agent_type
  has_many :runs
  has_many :webhooks

  def execute
    # TODO: enqueue job
  end
end
