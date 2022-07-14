# Preview all emails at http://localhost:3000/rails/mailers/radius_server_mailer
class RadiusServerMailerPreview < ActionMailer::Preview

  def new_idp_institutional
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'created').idp_institutional
  end  

  def new_idp_national
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'created').idp_national
  end  

  def updated_idp_institutional
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'updated').idp_institutional
  end  

  def updated_idp_national
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'updated').idp_national
  end  

  def deleted_idp_institutional
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'deleted').idp_institutional
  end  

  def deleted_idp_national
    RadiusServerMailer.with(radius_server: RadiusServer.find_by(name: "radius.ubuntunet.net"), organisation: Organisation.find_by(name: "UbuntuNet Alliance"), action: 'deleted').idp_national
  end  

end
