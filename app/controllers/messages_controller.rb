# coding: utf-8
class MessagesController < ApplicationController
  #-------#
  # index #
  #-------#
  def index( room_id )
    @room = Room.where( id: room_id ).first
    @room.update_attributes( messages_count: Message.where(room_id: @room.id).count )

    if @room.permission != "public" and @room.user_id != session[:user_id]
      flash[:alert] = "閲覧権限がありません。"
      redirect_to root_path and return
    end

    @messages = Message.where( room_id: room_id ).order( "created_at DESC" ).all
    @message = Message.new
  end

  #------#
  # list #
  #------#
  def list( room_id )
    room     = Room.where( id: room_id ).first
    messages = Message.where( room_id: room_id ).order( "created_at DESC" ).all

    render partial: 'messages', locals: { room: room, messages: messages }
  end

  #--------#
  # create #
  #--------#
  def create( room_id, message )
    @message = Message.new( message )
    @message.user_id = session[:user_id]
    @message.room_id = room_id

    user = User.where( id: @message.user_id ).first
    @room = Room.where( id: room_id ).first

    if @message.save
      # Pusherトリガー
      Pusher["channel_room_#{room_id}"].trigger( "message_event_room_#{room_id}", { room_id: @room.id, icon: user.image, title: @room.title, message: @message.sentence } )

      redirect_to( room_messages_path( room_id ) )
    else
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

    # Pusherトリガー
    Pusher["channel_room_#{room_id}"].trigger( "message_event_room_#{room_id}", { room_id: room_id, icon: nil, title: nil, message: nil } )

    redirect_to( room_messages_path( room_id ) )
  end
end
