class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorite_chats = current_user.favorite_chats.order(created_at: :desc)
    @favorite_topics = current_user.favorite_topics.includes(:category)
  end

  def create
    @favorite = current_user.favorites.create(
      favoritable_type: params[:favoritable_type],
      favoritable_id: params[:favoritable_id]
    )
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def chat
    @chat = current_user.favorite_chats.find(params[:chat_id])
  end
end
