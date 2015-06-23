class AgentType < ActiveRecord::Base
  # TODO: I think we can later change script_path to point to a Git repo
  # with a specified project structure i.e. payload_schema.json, README, etc.

  # TODO: Validate that JobType is an existing job in /jobs

  has_many :agents

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :description, presence: true
  validates :sample_payload, presence: true
  validates :payload_schema, presence: true
  validates :sample_response, presence: true
  validates :job_type, presence: true
  validates :script_path, presence: true
  validate :sample_payload_follows_schema, if: :payload_schema?
  validate :validate_job_type, if: :job_type?

  def validate_job_type
    unless job_type.constantize
      errors.add(:job_type, 'does not exist')
    end
  end

  def sample_payload_follows_schema
    unless JSON::Validator.validate(payload_schema, sample_payload)
      errors.add(:sample_payload, 'is invalid for specified payload_schema')
    end
  end
end
