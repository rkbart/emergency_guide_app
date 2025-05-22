class CategoriesController < ApplicationController
  def index
  @category = Category.all
  end

  def import
  Category.import(params[:file])
  redirect_to root_url, notice: "User Data imported"
  end
end
