# Agents have singular jobs
class Agent < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent_type
  has_many :runs
  has_and_belongs_to_many :webhooks

  enum status: %w( active disabled )

  after_create :enqueue_job # Should trigger everytime status is set to active
  before_destroy :clear_jobs
  before_validation :generate_slug, on: :create

  validates :slug, uniqueness: true, presence: true
  validates :interval, numericality: { only_integer: true, greater_than: 0 }
  validates :agent_type, presence: true
  validates :interval, presence: true
  validates :payload, presence: true
  validate :payload_follows_schema
  # TODO: validate that active agents have associated jobs, and vice versa

  # Note: call disable! and enable! to save the change
  include AASM
  aasm column: :status, enum: true, no_direct_assignment: true do
    state :active, initial: true
    state :disabled

    event :enable do
      transitions from: :disabled, to: :active
      after do
        enqueue_job
      end
    end

    event :disable do
      transitions from: :active, to: :disabled
      after do
        clear_jobs
      end
    end
  end

  def jobs
    require 'sidekiq/api'
    queue = Sidekiq::Queue.new
    jobs = []
    queue.each do |job|
      is_my_job = (job.args[0]['arguments'][0]['agent_id'] == id)
      jobs << job if is_my_job
    end
    jobs
  end

  def clear_jobs
    require 'sidekiq/api'
    queue = Sidekiq::Queue.new
    queue.each do |job|
      is_my_job = (job.args[0]['arguments'][0]['agent_id'] == id)
      job.delete if job.args && is_my_job
    end
    true
  end

  def enqueue_job
    return unless agent_type.valid?
    params = {
      agent_id: id,
      payload: payload,
      script_path: agent_type.script_path
    }
    job = agent_type.job_type.constantize
    job.perform_later(params)
  end

  # Used in friendly URL generation
  def to_param
    slug
  end

  protected

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
end
