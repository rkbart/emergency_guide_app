require "csv"

class TopicsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def show
    @category = Category.find(params[:category_id])
    @topic = @category.topics.find(params[:id])
    @is_favorited = current_user.favorites.exists?(favoritable: @topic) if user_signed_in?
  end

  def import
    unless current_user.valid_password?(params[:password])
      redirect_to categories_path, alert: "Incorrect password. Import aborted."
      return
    end

    if params[:file].blank?
      redirect_to categories_path, alert: "No file selected."
      return
    end

    Topic.import(params[:file])
    redirect_to categories_path, notice: "Topics Data imported"
  end

  private

  def record_not_found
    redirect_to root_path, alert: "Record does not exist"
  end
end
