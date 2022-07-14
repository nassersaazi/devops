require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:opareto)
    @organisation = organisations(:maren)
    @location = locations(:office)
  end

  test "should get new" do
    get new_organisation_location_url @organisation
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post organisation_locations_url @organisation, params: { location: { ap_no: @location.ap_no, availability: @location.availability, hs20: @location.hs20, identifier: @location.identifier, info_url: @location.info_url, ipv6: @location.ipv6, name: @location.name, nat: @location.nat, operation_hours: @location.operation_hours, organisation_id: @location.organisation_id, port_restrict: @location.port_restrict, ssid: @location.ssid, stage: @location.stage, transmission: @location.transmission, transp_proxy: @location.transp_proxy, venue_type: @location.venue_type, wired_no: @location.wired_no } }
    end

    assert_redirected_to organisation_url(@organisation)
  end

  test "should show location" do
    get organisation_location_url @location, organisation_id: @organisation.id
    assert_response :success
  end

  test "should get edit" do
    get edit_organisation_location_url @location, organisation_id: @organisation.id
    assert_response :success
  end

  test "should update location" do
    patch organisation_location_url @location, organisation_id: @organisation.id, params: { location: { ap_no: @location.ap_no, availability: @location.availability, hs20: @location.hs20, identifier: @location.identifier, info_url: @location.info_url, ipv6: @location.ipv6, name: @location.name, nat: @location.nat, operation_hours: @location.operation_hours, organisation_id: @location.organisation_id, port_restrict: @location.port_restrict, ssid: @location.ssid, stage: @location.stage, transmission: @location.transmission, transp_proxy: @location.transp_proxy, venue_type: @location.venue_type, wired_no: @location.wired_no } }
    assert_redirected_to @organisation
  end

  test "should destroy location" do
    sign_in users(:mercedes)    
    @organisation = organisations(:ua)
    @location = locations(:noequip)
    assert_difference('Location.count', -1) do
      delete organisation_location_url(@organisation, @location)
    end
    assert_redirected_to @organisation
  end
end
