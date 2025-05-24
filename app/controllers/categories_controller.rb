class CategoriesController < ApplicationController
  before_action :set_user, only: [ :show ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
  @category = Category.all
    # render json: { message: "Success", data: @category  }
  end

  def import
  Category.import(params[:file])
  redirect_to categories_path, notice: "Category Data imported"
  end

  def show
    # render json: @category
  end

  private

  def set_user
    @category = Category.find(params[:id])
  end

  def record_not_found
    # render json: { error: "Record not found" }
    redirect_to root_path, alert: "Record does not exist"
  end
end
