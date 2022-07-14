require 'test_helper'

class RealmTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "realm is invalid if not unique" do
    Realm.create!(organisation: organisations(:ua), domain_name: "example.net")
    realm = Realm.new(organisation: organisations(:ua), domain_name: "example.net")
    realm.save
    assert_includes realm.errors, :domain_name
    assert_includes realm.errors[:domain_name], "has already been taken"
  end

  test "realm is invalid if it contains an @" do
    realm = Realm.new(domain_name: "@example.mw", organisation: organisations(:ua))
    assert realm.invalid?,                   "Realm with @ is valid"
    assert_includes realm.errors[:domain_name], "only allows letters and numbers"
  end

  test "subdomain realm is valid" do
    realm = Realm.new(domain_name: "staff.ubuntunet.net", organisation: organisations(:ua))
    assert realm.valid?,                   "Subdomain Realm is invalid"
  end

  test "sets generic flag if realm tld is not the same as federation tld" do
    realm = Realm.new(domain_name: "staff.ubuntunet.net", organisation: organisations(:ua))
    assert realm.valid?
    assert_equal true, realm.generic
  end

  test "don't set generic flag if realm tld is the same as federation tld" do
    realm = Realm.new(domain_name: "cc.ac.mw", organisation: organisations(:chanco))
    assert_equal false, realm.generic
  end

  test "generate a test_user and password for new realms" do
    realm = Realm.create!(domain_name: "example.mw", organisation: organisations(:ua))
    assert_not_nil realm.test_user, "No test user created"
    assert_not_nil realm.test_password, "No test password created"
  end

  test "Send out emails to IdP & NRO if a realm's domain_name is updated" do
    realm = realms(:maren_ac_mw)
    assert_enqueued_emails 2 do
      realm.update(domain_name: "newmaren.ac.mw")
    end
  end
  test "Send out additonal email to Regional RO if a realm's domain_name TLD is changed" do
    realm = realms(:maren_ac_mw)
    assert_enqueued_emails 3 do
      realm.update(domain_name: "maren.ac.net")
    end
  end

  test "Send out emails to IdP & NRO if a realm's subdomain flag is changed" do
    realm = realms(:maren_ac_mw)
    assert_enqueued_emails 2 do
      realm.update(allow_subdomains: false)
    end
  end

  test "Don't send out email if updated realm is not changed" do
    realm = realms(:maren_ac_mw)
    assert_enqueued_emails 0 do
      realm.update(domain_name: "maren.ac.mw", allow_subdomains: true)
    end
  end

  test "Send out emails to IdP & NRO if a realm is deleted" do
    realm = realms(:maren_ac_mw)
    assert_emails 2 do
      realm.destroy
    end
  end
  test "Send out additonal email to Regional RO if the deleted realm is generic" do
    realm = realms(:ubuntunet_net)
    assert_emails 3 do
      realm.destroy
    end
  end

end
