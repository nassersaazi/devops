require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  test "Mandatory attributes must not be empty" do
    address = Address.new
    assert address.invalid?,            "Incomplete Address is valid"
    assert address.errors[:street].any?,  "Missing street doesn't show error"
    assert address.errors[:city].any?, "Missing city doesn't show error"
    assert address.errors[:country_code].any?, "Missing country doesn't show error"
  end

  test "It returns correct coordinates from Lat and Lng" do
    address = Address.new(latitude: 1.23, longitude: 4.22)
    assert_equal "1.23,4.22", address.coordinates,  "Lat/Lng returns wrong coordinates"
  end

  test "It returns empty string if coordinates were not found" do
    address = Address.new(latitude: "", longitude: "")
    assert_equal "", address.coordinates,  "Missing Coordinates return non-empty string"
  end

end
