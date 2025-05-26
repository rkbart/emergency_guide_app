class ChecklistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checklist, only: [:edit, :update, :destroy]

  def index
    @checklists = current_user.checklists
  end

  def new
    @checklist = current_user.checklists.build
  end

  def create
    @checklist = current_user.checklists.build(checklist_params)
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
<<<<<<< HEAD
    @checklist.destroy
    redirect_to checklists_path, notice: "Item removed."
  end

  def print
    @checklists = current_user.checklists
=======
      @checklist.destroy
      redirect_to checklists_path, notice: "Item removed."
  end

  def print
    @checklists = Checklist.all
>>>>>>> 50d704d535def1e9594815e504679e88a4f456e4
    render pdf: "emergency_checklist", template: "checklists/print", formats: [:html], layout: "pdf"
  end

  private

  def set_checklist
<<<<<<< HEAD
    @checklist = current_user.checklists.find(params[:id])
=======
    @checklist = Checklist.find(params[:id])
>>>>>>> 50d704d535def1e9594815e504679e88a4f456e4
  end

  def checklist_params
    params.require(:checklist).permit(:items, :description, :checked)
  end
end
