# coding: utf-8
class RoomsController < ApplicationController
  #-------#
  # index #
  #-------#
  def index
    @rooms = Room.where( user_id: session[:user_id] ).all
  end

  #------#
  # show #
  #------#
  def show( id )
    @room = Room.where( id: id, user_id: session[:user_id] ).first
  end

  #-----#
  # new #
  #-----#
  def new
    @room = Room.new
  end

  #------#
  # edit #
  #------#
  def edit( id )
    @room = Room.where( id: id, user_id: session[:user_id] ).first
  end

  #--------#
  # create #
  #--------#
  def create( room )
    @room = Room.new( room )
    @room.user_id = session[:user_id]

    if @room.save
      redirect_to( rooms_path, notice: "Room was successfully created." )
    else
      render action: "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update( id, room )
    @room = Room.where( id: id, user_id: session[:user_id] ).first

    if @room.update_attributes( room )
      redirect_to( room_path( @room ), notice: "Room was successfully updated." )
    else
      render action: "edit", id: id
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy( id )
    @room = Room.where( id: id, user_id: session[:user_id] ).first
    @room.destroy

    redirect_to rooms_path
  end
end
