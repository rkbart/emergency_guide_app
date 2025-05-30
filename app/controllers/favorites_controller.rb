class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorite_chats = current_user.favorite_chats.order(created_at: :desc)
    @favorite_topics = current_user.favorite_topics.includes(:category)
  end

  def create
    @favorite = current_user.favorites.new(
      favoritable_type: params[:favoritable_type],
      favoritable_id: params[:favoritable_id]
    )

    if @favorite.save
      flash[:notice] = "Added to favorites."
    else
      flash[:alert] = @favorite.errors.full_messages.to_sentence.presence || "Could not add to favorites."
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])

    if @favorite&.destroy
      flash[:notice] = "Removed from favorites."
    else
      flash[:alert] = "Could not remove from favorites."
    end

    redirect_back(fallback_location: root_path)
  end

  def chat
    @chat = current_user.favorite_chats.find(params[:chat_id])
  end
end
