class Room < ActiveRecord::Base
  attr_accessible :permission, :title, :user_id

  belongs_to :user
end
