require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @organisation = organisations(:maren)
  end

  test "should get index" do
    get organisations_url
    assert_response :success
  end

  test "should get new" do
    get new_organisation_url
    assert_response :success
  end

  test "should create organisation" do
    assert_difference('Organisation.count') do
      post organisations_url, params: { organisation: { 
                                          name: @organisation.name,
                                          domain_name: @organisation.domain_name,
                                          federation_id: federations(:mw).id,
                                          country_code: @organisation.country_code, 
                                          eduroam_type: @organisation.eduroam_type, 
                                          info_url: @organisation.info_url, 
                                          policy_url: @organisation.policy_url 
                                        } 
                                      }
    end

    assert_redirected_to organisation_url(Organisation.order(:created_at).reverse_order.first)
  end

  test "should show organisation" do
    get organisation_url(@organisation)
    assert_response :success
  end

  test "should get edit" do
    get edit_organisation_url(@organisation)
    assert_response :success
  end

  test "should update organisation" do
    patch organisation_url(@organisation), params:  { organisation: { 
                                                        name: @organisation.name, 
                                                        country_code: @organisation.country_code 
                                                      } 
                                                    }
    assert_redirected_to organisation_url(@organisation)
  end

  test "should not destroy NRO organisation" do
    assert_raises ActiveRecord::DeleteRestrictionError do
      delete organisation_url(@organisation)
    end
  end

  test "should destroy non-NRO organisation" do
    assert_difference('Organisation.count', -1) do
      delete organisation_url organisations(:chanco)
    end
    assert_redirected_to organisations_url
  end

end
