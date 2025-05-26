class EmergencyContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_emergency_contact, only: [ :show, :edit, :update, :destroy ]

  def index
    @emergency_contacts = current_user.emergency_contacts
  end

  def show
  end

  def new
    @emergency_contact = current_user.emergency_contacts.new
  end

  def create
    @emergency_contact = current_user.emergency_contacts.new(emergency_contact_params)
    if @emergency_contact.save
      redirect_to @emergency_contact, notice: "Emergency contact created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @emergency_contact.update(emergency_contact_params)
      redirect_to @emergency_contact, notice: "Emergency contact updated."
    else
      render :edit
    end
  end

  def destroy
    @emergency_contact.destroy
    redirect_to emergency_contacts_path, notice: "Emergency contact deleted."
  end

  private

  def set_emergency_contact
    @emergency_contact = current_user.emergency_contacts.find(params[:id])
  end

  def emergency_contact_params
    params.require(:emergency_contact).permit(:agency_name, :phone_number, :location)
  end
end
