# Agents have singular jobs
class Agent < ActiveRecord::Base
  before_validation :generate_slug, on: :create
  validates :slug, uniqueness: true, presence: true

  validates :interval, numericality: { only_integer: true, greater_than: 0 }
  enum type: %w( uptime screenshot )

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

  def execute
    # TODO: enqueue job
  end
end
