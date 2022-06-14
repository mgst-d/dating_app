# This is MessagesController
class MessagesController < ApplicationController
  def create
    msg_params[:body] = 'Sorry :( Message must be no more than 255 characters!' if msg_params[:body].length > 255
    @message = current_user.messages.create(body: msg_params[:body], room_id: params[:room_id])
  end

  private

  def msg_params
    params.require(:message)
  end
end
