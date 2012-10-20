# coding: utf-8
class MessagesController < ApplicationController
  #-------#
  # index #
  #-------#
  def index( room_id )
    @room = Room.where( id: room_id ).first
    @messages = Message.where( room_id: room_id ).all
    @message = Message.new
  end

  #--------#
  # create #
  #--------#
  def create( room_id, message )
    @message = Message.new( message )
    @message.user_id = session[:user_id]
    @message.room_id = room_id

    if @message.save
      redirect_to( room_messages_path( room_id ) )
    else
      @room = Room.where( id: room_id ).first
      @messages = Message.where( room_id: room_id ).all
      flash[:alert] = "メッセージの投稿に失敗しました。"
      render action: "index"
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy( room_id, id )
    message = Message.where( room_id: room_id, id: id, user_id: session[:user_id] ).first
    message.present? ? message.destroy : flash[:alert] = "メッセージの削除に失敗しました。"

    redirect_to( room_messages_path( room_id ) )
  end
end
