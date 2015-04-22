class Event < ActiveRecord::Base
  belongs_to :run
  belongs_to :webhook
end
