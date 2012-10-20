class Room < ActiveRecord::Base
  attr_accessible :permission, :title, :user_id
end
