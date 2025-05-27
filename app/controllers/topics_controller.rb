class TopicsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def show
    @category = Category.find(params[:category_id])
    @topic = @category.topics.find(params[:id])
    @is_favorited = current_user.favorites.exists?(favoritable: @topic) if user_signed_in?
  end

  private

  def record_not_found
    redirect_to root_path, alert: "Record does not exist"
  end
end
