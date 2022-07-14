require 'test_helper'

class EquipmentControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    sign_in users(:opareto)
    @equipment = equipment(:corridor)
    @organisation = @equipment.organisation
  end

  test "should get new" do
    get new_organisation_equipment_url(@organisation)
    assert_response :success
  end

  test "should create equipment" do
    assert_difference('Equipment.count') do
      post organisation_equipment_index_url(@organisation), params: { equipment: { ip4: @equipment.ip4, ip6: @equipment.ip6, location_id: @equipment.location_id, mac: @equipment.mac, name: @equipment.name, nas_type: @equipment.nas_type, prefix4: @equipment.prefix4, prefix6: @equipment.prefix6, protocol: @equipment.protocol, require_message_authenticator: @equipment.require_message_authenticator, switchboard_secret: @equipment.switchboard_secret, upstream_secret: @equipment.upstream_secret } }
    end

    assert_redirected_to @organisation
  end

  test "should notify IdP managers about new equipment" do
    assert_enqueued_emails 1 do
      post organisation_equipment_index_url(@organisation), params: { equipment: { ip4: @equipment.ip4, ip6: @equipment.ip6, location_id: @equipment.location_id, mac: @equipment.mac, name: @equipment.name, nas_type: @equipment.nas_type, prefix4: @equipment.prefix4, prefix6: @equipment.prefix6, protocol: @equipment.protocol, require_message_authenticator: @equipment.require_message_authenticator, switchboard_secret: @equipment.switchboard_secret, upstream_secret: @equipment.upstream_secret } }
    end
  end

  test "should get edit" do
    get edit_organisation_equipment_url(@organisation, @equipment)
    assert_response :success
  end

  test "should update equipment" do
    patch organisation_equipment_url(@organisation, @equipment), params: { equipment: { ip4: @equipment.ip4, ip6: @equipment.ip6, location_id: @equipment.location_id, mac: @equipment.mac, name: @equipment.name, nas_type: @equipment.nas_type, prefix4: @equipment.prefix4, prefix6: @equipment.prefix6, protocol: @equipment.protocol, require_message_authenticator: @equipment.require_message_authenticator, switchboard_secret: @equipment.switchboard_secret, upstream_secret: @equipment.upstream_secret, monitor_secret: @equipment.monitor_secret } }
    assert_redirected_to @organisation
  end

  test "should destroy equipment" do
    assert_difference('Equipment.count', -1) do
      delete organisation_equipment_url(@organisation, @equipment)
    end

    assert_redirected_to @organisation
  end
end
