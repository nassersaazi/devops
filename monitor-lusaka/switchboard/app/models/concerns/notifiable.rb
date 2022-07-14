module Notifiable
  extend ActiveSupport::Concern

  private

  # Realms
  def send_new_realm_notifications
    realm_with('created').institutional.deliver_later
    realm_with('created').national.deliver_later    
    realm_with('created').regional.deliver_later if generic?
  end

  def send_updated_realm_notifications
    if saved_change_to_domain_name || saved_change_to_allow_subdomains?
      realm_with('updated').institutional.deliver_later
      realm_with('updated').national.deliver_later
      realm_with('updated').regional.deliver_later if generic?
    end
  end

  def send_deleted_realm_notifications
    realm_with('deleted').institutional.deliver_now
    realm_with('deleted').national.deliver_now   
    realm_with('deleted').regional.deliver_now if generic?
  end

  def realm_with(action)
    RealmMailer.with(realm: self, organisation: self.organisation, action: action)
  end

  # Equipment
  def notify_about_new_equipment
    EquipmentMailer.with(equipment: self, organisation: self.location.organisation, action: 'created').institutional.deliver_later
  end
  
  def notify_about_updated_equipment
    EquipmentMailer.with(equipment: self, organisation: self.location.organisation, action: 'updated').institutional.deliver_later
  end
  
  def notify_about_deleted_equipment
    EquipmentMailer.with(equipment: self, organisation: self.location.organisation, action: 'deleted').institutional.deliver_now
  end
  
  # Radius Servers
  def notify_about_new_radius_server
    if self.radiusable_type == "Organisation"
      RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'created').idp_institutional.deliver_later
      RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'created').idp_national.deliver_later
    end
  end

  def notify_about_updated_radius_server
    relevant_attributes = [
      "name", 
      "ip4", "ip6", 
      "protocol", 
      "upstream_secret", 
      "require_message_authenticator",
      "auth", "auth_port",
      "acct", "acct_port"
    ]
    relevant_changes = self.saved_changes.keys & relevant_attributes
    unless relevant_changes.empty?
      if self.radiusable_type == "Organisation"
        RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'updated').idp_institutional.deliver_later
        RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'updated').idp_national.deliver_later  
      end
    end
  end

  def notify_about_deleted_radius_server
    if self.radiusable_type == "Organisation"
      RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'deleted').idp_institutional.deliver_now
      RadiusServerMailer.with(radius_server: self, organisation: self.radiusable, action: 'deleted').idp_national.deliver_now
    end
  end

end