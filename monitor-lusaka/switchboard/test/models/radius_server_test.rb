require 'test_helper'

class RadiusServerTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "Mandatory attributes must not be empty" do
    rs = RadiusServer.new
    assert rs.invalid?,                   "Incomplete Radius Server is valid"
    assert rs.errors[:name].any?,         "Missing name doesn't show error"
    assert rs.errors[:server_type].any?, "Missing server_type doesn't show error"
  end

  test "ip4 must be a valid IPv4 address" do
    rs = RadiusServer.new(ip4: 3122323)
    assert rs.invalid?
    assert rs.errors[:ip4].any?
  end  

  test "ip4 must be a valid IPv6 address" do
    rs = RadiusServer.new(ip6: '192.168.0.1')
    assert rs.invalid?
    assert rs.errors[:ip6].any?
  end  

  test "mac must be a valid MAC address" do
    rs = RadiusServer.new(mac: 'sfpofsadff')
    assert rs.invalid?
    assert rs.errors[:mac].any?
  end  

  test "return correct auth/acct type for proxy.conf" do
    auth_only = RadiusServer.new(auth: true, acct: false)
    assert_equal "auth", auth_only.auth_acct[:type]
    acct_only = RadiusServer.new(auth: false, acct: true)
    assert_equal "acct", acct_only.auth_acct[:type]
    authacct = RadiusServer.new(auth: true, acct: true)
    assert_equal "auth+acct", authacct.auth_acct[:type]
    noneofthetwo = RadiusServer.new(auth: false, acct: false)
    assert noneofthetwo.invalid?
    assert noneofthetwo.errors[:auth].any?
    assert noneofthetwo.errors[:acct].any?
  end

  test "returns correct ports for auth and/or acct" do
    auth_only = RadiusServer.new(auth: true, acct: false, auth_port: 1812, acct_port: 1813)
    assert_equal "1812", auth_only.auth_acct[:ports]
    acct_only = RadiusServer.new(auth: false, acct: true, auth_port: 1812, acct_port: 1813)
    assert_equal "1813", acct_only.auth_acct[:ports]
    authacct = RadiusServer.new(auth: true, acct: true, auth_port: 1812, acct_port: 1813)
    assert_equal "1812,1813", authacct.auth_acct[:ports]
  end

  test "returns FLRs for IdPs" do
    idp = radius_servers(:ua_idp)
    assert_includes idp.upstream_servers, radius_servers(:mw_fpa)
    idp.upstream_servers.each do |fp|
      assert_equal 'fp', fp.server_type
    end
  end

  test "returns RPs for FLRs" do
    fp = radius_servers(:mw_fpa)
    assert_equal fp.upstream_servers, RadiusServer.type(:rp)
    fp.upstream_servers.each do |rp|
      assert_equal 'rp', rp.server_type
    end
  end

  test "returns ETLRs for RPs" do
    rp = radius_servers(:africa_rp1)
    assert_equal rp.upstream_servers, RadiusServer.type(:tlr)
    rp.upstream_servers.each do |tlr|
      assert_equal 'tlr', tlr.server_type
    end
  end

  # Notifications IdP
  test "notify own IdP managers and NROs about new IdP" do
    assert_enqueued_emails 2 do
      RadiusServer.create(name: "test_idp", radiusable: organisations(:ua), server_type: 'idp', ip4: '1.2.3.4', auth: true, acct: false, auth_port: 1812, acct_port: 1813)
    end
  end

  test "notify own IdP managers and NROs about relevant updates on IdP" do
    idp = radius_servers(:ua_idp)
    assert_enqueued_emails 2 do
      idp.update(ip4: '1.2.3.4')
    end
  end

  test "do not notify about irrelevant updates on IdP" do
    idp = radius_servers(:ua_idp)
    assert_enqueued_emails 0 do
      idp.update(mac: 'aa:00:00:dd:6d:aa')
    end
  end

  test "notify IdP managers about deleted IdP" do
    idp = radius_servers(:ua_idp)
    assert_emails 2 do
      idp.destroy
    end
  end


  # Notifications FLR
  # test "notify all IdP managers, NROs and ConfAdmins about new FLR" do
  #   assert_enqueued_emails 3 do
  #     RadiusServer.create(name: "test_flr", radiusable: federations(:mw), server_type: 'flr', ip4: '1.2.3.4', auth: true, acct: false, auth_port: 1812, acct_port: 1813)
  #   end
  # end


end
