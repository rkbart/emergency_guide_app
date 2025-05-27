class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true).includes(:topics)
  end

  def show
    @category = Category.includes(:topics).find(params[:id])
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

    Category.import(params[:file])
    redirect_to categories_path, notice: "Category Data imported"
  end

  private

  def record_not_found
    redirect_to root_path, alert: "Record does not exist"
  end
end
