class TopicsController < ApplicationController
  before_action :set_id
  before_action :set_action, only: %i[show ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @topics = @category.topics

    # render json: { message: "Success", data: @topics }
  end

  def import
    Topic.import(params[:file])
    redirect_to topics_path, notice: "Topics imported successfully!"
  end

  def show
    # render json: @category
  end

  private

  def set_id
    @category = Category.find(params[:category_id])
  end

  def set_action
    @topic = @category.topics.find(params[:id])
  end

  def record_not_found
    # render json: { error: "Record not found" }
    redirect_to root_path, alert: "Record does not exist"
  end
end
