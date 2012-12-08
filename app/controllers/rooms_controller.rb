# coding: utf-8
class RoomsController < ApplicationController
  #-------#
  # index #
  #-------#
  def index( room_type )
    puts "[ ---------- params[:controller] ---------- ]" ; params[:controller].tapp ;

    if room_type.present?
      @rooms = Room.where( user_id: session[:user_id] ).order( "created_at DESC" )

      case room_type
      when "public"
        @rooms = @rooms.where( permission: "public" ).all
      when "member"
        @rooms = @rooms.where( permission: "member" ).all
      when "approval"
        @rooms = @rooms.where( permission: "approval" ).all
      when "private"
        @rooms = @rooms.where( permission: "private" ).all
      end
    else
      @rooms = Room.where( permission: "public" ).order( "created_at DESC" ).all
    end
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
      redirect_to( rooms_path( room_type: @room.permission ), notice: "ルームを作成しました。" )
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
    room = Room.where( id: id, user_id: session[:user_id] ).first
    room.destroy

    redirect_to rooms_path
  end
end
