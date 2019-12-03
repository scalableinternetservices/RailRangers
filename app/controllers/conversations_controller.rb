require 'will_paginate/array'
class ConversationsController < ApplicationController

  layout false

  # GET /comments
  # GET /comments.json
  def new
    @conversation = Conversation.new
  end

  def index
    @conversation = Conversation.all
  end


  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    respond_to do |format|
      format.html { redirect_to @conversation }
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    # @messages = @conversation.messages.includes(:user).order("created_at DESC")
    # @messages = @messages.paginate(:page => params[:page], :per_page => 30).reverse
    @messages = Message.where('conversation_id != ?' , @conversation.id).paginate(:page => params[:page], :per_page => 30).order("created_at DESC").reverse
    @receiver = interlocutor(@conversation)
    @message = Message.new
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
