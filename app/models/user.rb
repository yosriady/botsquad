class User < ActiveRecord::Base
  has_many :agents

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable
  before_create :generate_api_key

  protected

  def generate_api_key
    self.api_key = loop do
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless self.class.exists?(api_key: random_token)
    end
  end
end
