# Agents have singular jobs
class Agent < ActiveRecord::Base
  after_create :enqueue_job # Should trigger everytime status is set to active

  before_validation :generate_slug, on: :create
  validates :slug, uniqueness: true, presence: true

  validates :interval, numericality: { only_integer: true, greater_than: 0 }
  enum status: %w( active disabled )
  validates :agent_type, presence: true
  validates :interval, presence: true
  validates :payload, presence: true
  validate :payload_follows_schema

  belongs_to :user
  belongs_to :agent_type
  has_many :runs
  has_and_belongs_to_many :webhooks

  # Used in friendly URL generation
  def to_param
    slug
  end

  def generate_slug
    self.slug = loop do
      random_slug = Haikunator.haikunate
      break random_slug unless self.class.exists?(slug: random_slug)
    end
  end

  def payload_follows_schema
    valid = !agent_type.payload_schema? || (agent_type.payload_schema? && JSON::Validator.validate(agent_type.payload_schema, payload))
    errors.add(:payload, 'is invalid for specified payload_schema') unless valid
  end

  def enqueue_job
    return unless agent_type.job_type.constantize
    job_params = {
      agent_id: id,
      payload: payload,
      script_path: agent_type.script_path
    }
    agent_type.job_type.constantize.perform_later(job_params)
  end
end
