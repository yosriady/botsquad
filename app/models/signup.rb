class Signup < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates_email_format_of :email
end
