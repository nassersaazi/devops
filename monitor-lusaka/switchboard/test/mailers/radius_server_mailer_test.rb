require 'test_helper'

class RadiusServerMailerTest < ActionMailer::TestCase

  test "send mail to IdP manager when new IdP is created" do
    organisation = organisations(:ua)
    radius_server = radius_servers(:ua_idp)
    email = RadiusServerMailer.with(radius_server: radius_server, organisation: organisation, action: 'created').idp_institutional

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal organisation.users.pluck(:email), email.to
    assert_equal "[eduroam Switchboard] IdP RADIUS server '#{radius_server.name}' just got created", email.subject
    assert_equal read_fixture('idp_create_institutional').join, email.body.to_s    
  end

  test "send mail to NRO when new IdP is created in their federation" do
    organisation = organisations(:ua)
    radius_server = radius_servers(:ua_idp)
    email = RadiusServerMailer.with(radius_server: radius_server, organisation: organisation, action: 'created').idp_national

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal ["#{organisation.federation.email}"], email.to
    assert_equal "[eduroam Switchboard] #{organisation.name} just created the IdP server '#{radius_server.name}'", email.subject
    assert_equal read_fixture('idp_create_national').join, email.body.to_s    
  end

end
