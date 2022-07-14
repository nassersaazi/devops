# Preview all emails at http://localhost:3000/rails/mailers/equipment_mailer
class EquipmentMailerPreview < ActionMailer::Preview

  def new_equipment_institutional
    EquipmentMailer.with(equipment: Equipment.first, organisation: Organisation.first, action: 'created').institutional
  end  

  def updated_equipment_institutional
    EquipmentMailer.with(equipment: Equipment.first, organisation: Organisation.first, action: 'updated').institutional
  end  

  def deleted_equipment_institutional
    EquipmentMailer.with(equipment: Equipment.first, organisation: Organisation.first, action: 'deleted').institutional
  end  

end
