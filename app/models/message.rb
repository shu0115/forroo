class Message < ActiveRecord::Base
  attr_accessible :room_id, :sentence, :user_id

  belongs_to :user
  belongs_to :room

  # カウンターキャッシュ
  counter_culture :room

  private

  #-----------------#
  # self.uniq_users #
  #-----------------#
  def self.uniq_users( messages )
    messages.uniq{ |m| m.user_id }.map{ |m| m.user }
  end
end
