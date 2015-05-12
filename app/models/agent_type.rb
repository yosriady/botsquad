class AgentType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :agents

  validates :name, presence: true
  validates :description, presence: true
  validates :sample_payload, presence: true
  validates :payload_schema, presence: true
  validate :sample_payload_follows_schema, if: :payload_schema?
  validates :sample_response, presence: true
  validates :job_type, presence: true
  validates :script_path, presence: true

  def sample_payload_follows_schema
    unless JSON::Validator.validate(payload_schema, sample_payload)
      errors.add(:sample_payload, 'is invalid for specified payload_schema')
    end
  end
end
