class Message < ActiveRecord::Base
  attr_accessible :room_id, :sentence, :user_id

  belongs_to :user
end
