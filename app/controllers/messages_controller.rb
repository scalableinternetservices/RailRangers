class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)
    @message.user_id = current_user.id
    @message.save!

    respond_to do |format|
      format.html { redirect_to @conversation }
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
