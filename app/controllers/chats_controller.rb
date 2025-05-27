class ChatsController < ApplicationController
  before_action :authenticate_user!
  def show
    @chat = current_user.chats.find(params[:id])
  end
end
