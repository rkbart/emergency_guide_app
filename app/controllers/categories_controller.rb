class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @categories = Category.includes(:topics).all
  end

  def show
    @category = Category.includes(:topics).find(params[:id])
  end

  private

  def record_not_found
    redirect_to root_path, alert: "Record does not exist"
  end
end
