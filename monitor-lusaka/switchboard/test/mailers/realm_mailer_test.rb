require 'test_helper'

class RealmMailerTest < ActionMailer::TestCase

  test "send correct mail to IdP manager when new realm is created" do
    organisation = organisations(:ua)
    realm = realms(:ubuntunet_mw)
    email = RealmMailer.with(realm: realm, organisation: organisation, action: 'created').institutional

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal organisation.users.pluck(:email), email.to
    assert_equal "[eduroam Switchboard] Realm '#{realm.domain_name}' just got created", email.subject
    assert_equal read_fixture('realm_create_institutional').join, email.body.to_s    
  end

  # Makes no difference to the NRO if a realm is generic or not
  test "send correct mail to national RO when new realm is created" do
    organisation = organisations(:ua)
    realm = realms(:ubuntunet_mw)
    email = RealmMailer.with(realm: realm, organisation: organisation, action: 'created').national

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal ["#{organisation.federation.email}"], email.to
    assert_equal "[eduroam Switchboard] #{organisation.name} just created the realm '#{realm.domain_name}'", email.subject
    assert_equal read_fixture('realm_create_national').join, email.body.to_s    
  end

  test "Notify regional Confederation Operator when new generic realm is created" do
    organisation = organisations(:ua)
    realm = realms(:ubuntunet_net)
    email = RealmMailer.with(realm: realm, organisation: organisation, action: 'created').regional

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal ["#{organisation.federation.confederation.email}"], email.to
    assert_equal "[eduroam Switchboard] UbuntuNet Alliance just created the generic realm 'ubuntunet.net' in your eduroam confederation", email.subject
    assert_equal read_fixture('realm_create_regional').join, email.body.to_s    
  end

end
