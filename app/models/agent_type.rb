class AgentType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :agents
end
