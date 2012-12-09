class Room < ActiveRecord::Base
  attr_accessible :permission, :title, :user_id, :messages_count

  belongs_to :user
  has_many :messages

  private

  #--------------------#
  # self.active_rooms? #
  #--------------------#
  def self.active_rooms?( args=Hash.new )
    if args[:controller] == 'rooms' and args[:room_type].blank?
      true
    else
      false
    end
  end

  #---------------------#
  # self.active_public? #
  #---------------------#
  def self.active_public?( args=Hash.new )
    if args[:controller] == "rooms" and args[:room_type] == "public"
      true
    else
      false
    end
  end

  #---------------------#
  # self.active_member? #
  #---------------------#
  def self.active_member?( args=Hash.new )
    if args[:controller] == "rooms" and args[:room_type] == "member"
      true
    else
      false
    end
  end

  #-----------------------#
  # self.active_approval? #
  #-----------------------#
  def self.active_approval?( args=Hash.new )
    if args[:controller] == "rooms" and args[:room_type] == "approval"
      true
    else
      false
    end
  end

  #----------------------#
  # self.active_private? #
  #----------------------#
  def self.active_private?( args=Hash.new )
    if args[:controller] == "rooms" and args[:room_type] == "private"
      true
    else
      false
    end
  end
end
