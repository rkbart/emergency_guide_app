class EmergencyContactsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_emergency_contact, only: [ :show, :edit, :update, :destroy ]

  def index
    @emergency_contacts = EmergencyContact.for_display(current_user)
  end

  def show; end

  def new
    @emergency_contact = current_user.emergency_contacts.new
  end

  def create
    @emergency_contact = current_user.emergency_contacts.new(emergency_contact_params)
    if @emergency_contact.save
      redirect_to emergency_contacts_path, notice: "Emergency contact created."
    else
      flash.now[:alert] = @emergency_contact.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @emergency_contact.update(emergency_contact_params)
      redirect_to emergency_contacts_path, notice: "Contact updated successfully!"
    else
      flash.now[:alert] = @emergency_contact.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @emergency_contact.destroy
    redirect_to emergency_contacts_path, notice: "Emergency contact deleted."
  end

  private

  def set_emergency_contact
    @emergency_contact =
      if current_user
        current_user.emergency_contacts.find(params[:id])
      else
        EmergencyContact.system_defaults.find(params[:id])
      end
  end

  def emergency_contact_params
    params.require(:emergency_contact).permit(:agency_name, :phone_number, :location)
  end
end
