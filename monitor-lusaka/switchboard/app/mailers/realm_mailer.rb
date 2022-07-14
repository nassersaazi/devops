class RealmMailer < ApplicationMailer

  before_action { @action, @realm, @organisation = params[:action], params[:realm], params[:organisation] }

  def institutional
    mail(to: @organisation.users.pluck(:email), subject: "[eduroam Switchboard] Realm '#{@realm.domain_name}' just got #{@action}")
  end

  def national
    @federation = @organisation.federation
    mail(to: @federation.email, subject: "[eduroam Switchboard] #{@organisation.name} just #{@action} the realm '#{@realm.domain_name}'")
  end

  def regional
    @confederation = @organisation.federation.confederation
    mail(to: @confederation.email, subject: "[eduroam Switchboard] #{@organisation.name} just #{@action} the generic realm '#{@realm.domain_name}' in your eduroam confederation")
  end

end
