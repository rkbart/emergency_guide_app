class ChecklistsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_checklist, only: [ :edit, :update, :destroy ]

  def index
    @checklists = Checklist.for_display(current_user)
  end

  def new
    @checklist = current_user.checklists.new
  end

  def create
    @checklist = current_user.checklists.new(checklist_params)
    if @checklist.save
      redirect_to checklists_path, notice: "Item added successfully."
    else
      flash.now[:alert] = @checklist.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @checklist.update(checklist_params)
      redirect_to checklists_path, notice: "Item updated."
    else
      flash.now[:alert] = @checklist.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist.destroy
    redirect_to checklists_path, notice: "Item removed."
  end

  private

  def set_checklist
    @checklist =
      if current_user
        current_user.checklists.find(params[:id])
      else
        Checklist.system_defaults.find(params[:id])
      end
  end

  def checklist_params
    params.require(:checklist).permit(:items, :description, :checked)
  end
end
