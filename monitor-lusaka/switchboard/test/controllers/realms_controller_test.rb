require 'test_helper'

class RealmsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    sign_in users(:opareto)
    @organisation = organisations(:maren)
    @realm = realms(:maren_ac_mw)
  end

  test "should get new" do
    get new_organisation_realm_url organisation_id: @organisation.id
    assert_response :success
  end

  test "should get edit" do
    get edit_organisation_realm_url @realm, organisation_id: @organisation.id
    assert_response :success
  end

  test "Notify IdP, FP and Regional Operator of generic Realm creation" do
    assert_enqueued_emails 3 do
      post organisation_realms_url organisation_id: @organisation.id, params: { realm: { domain_name: 'example.org' }}
    end
  end

  test "Notify IdP and FP only of non-generic Realm creation" do
    assert_enqueued_emails 2 do
      post organisation_realms_url organisation_id: @organisation.id, params: { realm: { domain_name: 'example.mw' }}
    end
  end

  test "Doesn't send out notifications if realm is invalid" do
    assert_enqueued_emails 0 do
      post organisation_realms_url organisation_id: @organisation.id, params: { realm: { domain_name: 'example@mw' }}
    end
  end

end
