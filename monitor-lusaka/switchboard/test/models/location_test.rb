require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test "Returns correct tags" do
    location = locations(:kitchen)
    assert_equal "", location.tag, "No options enabled fails"
    location.port_restrict = true
    assert_equal "port_restrict", location.tag, "port_restrict enabled fails"
    location.nat = true
    assert_equal "port_restrict,NAT", location.tag, "port_restrict & NAT enabled fails"
  end

  test "returns correct encryption level" do
    location = Location.new(wpa_mode: "wpa", encryption_mode: "aes")
    assert_equal "wpa/aes", location.enc_level
    location = Location.new(wpa_mode: "wpa", encryption_mode: "tkip")
    assert_equal "wpa/tkip", location.enc_level
    location = Location.new(wpa_mode: "wpa", encryption_mode: "both")
    assert_equal "wpa/aes,wpa/tkip", location.enc_level
    location = Location.new(wpa_mode: "both", encryption_mode: "both")
    assert_equal "wpa/aes,wpa/tkip,wpa2/aes,wpa2/tkip", location.enc_level
  end

end
