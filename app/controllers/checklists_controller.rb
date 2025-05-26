class ChecklistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checklist, only: [ :edit, :update, :destroy ]

  def index
    @checklists = current_user.checklists
  end

  def new
    @checklist = current_user.checklists.new
  end

  def create
    @checklist = current_user.checklists.new(checklist_params)

    if @checklist.save
      redirect_to checklists_path, notice: "Item added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @checklist.update(checklist_params)
      redirect_to checklists_path, notice: "Item updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist.destroy
    redirect_to checklists_path, notice: "Item removed."
  end


  private

  def set_checklist
    @checklist = current_user.checklists.find(params[:id])
  end

  private

  def set_checklist
    @checklist = current_user.checklists.find(params[:id])
  end

  def checklist_params
    params.require(:checklist).permit(:items, :description, :checked)
  end
end
