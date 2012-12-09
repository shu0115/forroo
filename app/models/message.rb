class Message < ActiveRecord::Base
  attr_accessible :room_id, :sentence, :user_id

  belongs_to :user
  belongs_to :room

  # カウンターキャッシュ
  counter_culture :room
end
