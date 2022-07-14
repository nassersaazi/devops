require 'test_helper'

class FederationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @federation = federations(:mw)
    @operator = organisations(:maren)
    @confederation = confederations(:africa)
  end

  test "operator should get index" do
    sign_in users(:opareto)
    get federations_url
    assert_response :success
  end


  test "operator shouldn't get new" do
    sign_in users(:opareto)
    get new_federation_url
    assert_redirected_to root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]    
    # assert_raises(Pundit::NotAuthorizedError) {
    #   get new_federation_url
    # }
  end

  test "admin should get new" do
    sign_in users(:admin)
    get new_federation_url
    assert_response :success
  end

  test "should create federation" do
    sign_in users(:admin)
    assert_difference('Federation.count') do
      post federations_url, params: { federation: { identifier: @federation.identifier, operator_id: @operator.id, confederation_id: @confederation.id, stage: @federation.stage, email: @federation.email, tld: "ME", language: @federation.language, info_url: @federation.info_url, policy_url: @federation.policy_url } }
    end

    assert_redirected_to federations_url
  end

  test "should show federation" do
    sign_in users(:opareto)
    get federation_url(@federation)
    assert_response :success
  end

  test "admin should get edit" do
    sign_in users(:admin)
    get edit_federation_url(@federation)
    assert_response :success
  end

  test "should update federation" do
    sign_in users(:opareto)
    patch federation_url @federation, params: { 
      federation: { 
        identifier: @federation.identifier, 
        operator_id: @operator.id, 
        language: @federation.language, 
        stage: @federation.stage, 
        tld: @federation.tld, 
        info_url: @federation.info_url, 
        policy_url: @federation.policy_url 
      }
    }
    assert_redirected_to @federation
  end

  test "should destroy federation" do
    sign_in users(:admin)
    assert_difference('Federation.count', -1) do
      delete federation_url(@federation.id)
    end

    assert_redirected_to federations_url
  end
end
