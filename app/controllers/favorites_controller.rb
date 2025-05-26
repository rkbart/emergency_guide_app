class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_topics = current_user.favorite_topics
  end

  def create
    @topic = Topic.find(params[:topic_id])
    current_user.favorites.create(topic: @topic)
    redirect_back fallback_location: root_path, notice: "Topic added to favorites."
  end

  def destroy
    @favorite = current_user.favorites.find_by(topic_id: params[:topic_id])
    @favorite.destroy if @favorite
    redirect_back fallback_location: root_path, notice: "Topic removed from favorites."
  end
end
