class RadiusServerMailer < ApplicationMailer

  before_action { @action, @radius_server, @organisation = params[:action], params[:radius_server], params[:organisation] }

  def idp_institutional
    mail(to: @organisation.users.pluck(:email), subject: "[eduroam Switchboard] IdP RADIUS server '#{@radius_server.name}' just got #{@action}")
  end

  def idp_national
    @federation = @organisation.federation
    mail(to: @organisation.federation.email, subject: "[eduroam Switchboard] #{@organisation.name} just created the IdP server '#{@radius_server.name}'")
  end

  # def idp_switchboard
  # end

  # def flr_institutional
  # end

  # def flr_national
  # end

  # def flr_regional
  # end

  # def flr_switchboard
  # end

  # def flr_monitoring
  # TODO
  # end

end
