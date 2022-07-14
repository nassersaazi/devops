class EquipmentMailer < ApplicationMailer

  before_action { @action, @equipment, @organisation = params[:action], params[:equipment], params[:organisation] }

  def institutional
    mail(to: @organisation.users.pluck(:email), subject: "[eduroam Switchboard] Equipment '#{@equipment.name}' at #{@equipment.location.name} just got #{@action}")
  end

end
