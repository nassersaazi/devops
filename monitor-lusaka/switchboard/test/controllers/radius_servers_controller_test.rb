require 'test_helper'

class RadiusServersControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    sign_in users(:mercedes)
    @radius_server = radius_servers(:ua_idp)
    @radiusable = @radius_server.radiusable
  end

  test "should get new" do
    get polymorphic_url([@radiusable, RadiusServer], action: :new)
    assert_response :success
  end

  test "should create radius_server" do
    assert_difference('RadiusServer.count') do
      post polymorphic_url([@radiusable, RadiusServer]), params: { radius_server: { acct: @radius_server.acct, acct_port: @radius_server.acct_port, auth: @radius_server.auth, auth_port: @radius_server.auth_port, ip4: @radius_server.ip4, ip6: @radius_server.ip6, server_type: @radius_server.server_type, product: @radius_server.product, name: @radius_server.name, protocol: @radius_server.protocol, require_message_authenticator: @radius_server.require_message_authenticator, upstream_secret: @radius_server.upstream_secret } }
    end

    assert_redirected_to polymorphic_url(@radiusable)
  end

  test "should notify IdP managers and NROs about new IdP" do
    assert_enqueued_emails 2 do
      post polymorphic_url([@radiusable, RadiusServer]), params: { radius_server: { acct: @radius_server.acct, acct_port: @radius_server.acct_port, auth: @radius_server.auth, auth_port: @radius_server.auth_port, ip4: @radius_server.ip4, ip6: @radius_server.ip6, server_type: @radius_server.server_type, product: @radius_server.product, name: @radius_server.name, protocol: @radius_server.protocol, require_message_authenticator: @radius_server.require_message_authenticator, upstream_secret: @radius_server.upstream_secret } }
    end
  end

  test "should notify all federatedIdP managers, NROs and RPOs about new FLR" do
    @flr = radius_servers(:mw_fpa)
    assert_enqueued_emails 2 do
      post polymorphic_url([@radiusable, RadiusServer]), params: { radius_server: { acct: @flr.acct, acct_port: @flr.acct_port, auth: @flr.auth, auth_port: @flr.auth_port, ip4: @flr.ip4, ip6: @flr.ip6, server_type: @flr.server_type, product: @flr.product, name: @flr.name, protocol: @flr.protocol, require_message_authenticator: @flr.require_message_authenticator, upstream_secret: @flr.upstream_secret } }
    end
  end

  test "should show radius_server" do
    get polymorphic_url([@radiusable, @radius_server])
    assert_response :success
  end

  test "should get edit" do
    get polymorphic_url([@radiusable, @radius_server], action: :edit)
    assert_response :success
  end

  test "should update radius_server" do
    patch polymorphic_url([@radiusable, @radius_server]), params: { radius_server: { acct: @radius_server.acct, acct_port: @radius_server.acct_port, auth: @radius_server.auth, auth_port: @radius_server.auth_port, ip4: @radius_server.ip4, ip6: @radius_server.ip6, server_type: @radius_server.server_type, product: @radius_server.product, name: @radius_server.name, protocol: @radius_server.protocol, require_message_authenticator: @radius_server.require_message_authenticator, upstream_secret: @radius_server.upstream_secret } }
    assert_redirected_to polymorphic_url(@radiusable)
  end

  test "should destroy radius_server" do
    assert_difference('RadiusServer.count', -1) do
      delete polymorphic_url([@radiusable, @radius_server])
    end
    assert_redirected_to polymorphic_url(@radiusable)
  end
end
