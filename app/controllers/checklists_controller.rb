class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:edit, :update, :destroy]

  def index
    @checklists = Checklist.all
  end

  def new
    @checklist = Checklist.new
  end

  def create
    @checklist = Checklist.new(checklist_params)
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

  def print
    @checklists = Checklist.all
    render pdf: "emergency_checklist", template: "checklists/print", formats: [:html], layout: "pdf"
  end

  private

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end

  def checklist_params
    params.require(:checklist).permit(:items, :description, :checked)
  end
end
