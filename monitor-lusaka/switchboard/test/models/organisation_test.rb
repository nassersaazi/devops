require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase

  test "Mandatory attributes must not be empty" do
    organisation = Organisation.new
    assert organisation.invalid?,                   "Incomplete Organisation is valid"
    assert organisation.errors[:name].any?,         "Missing name doesn't show error"
    assert organisation.errors[:country_code].any?, "Missing country_code doesn't show error"
    assert organisation.errors[:eduroam_type].any?, "Missing eduroam_type doesn't show error"
    assert organisation.errors[:info_url].any?,     "Missing Info URL doesn't show error"
    assert organisation.errors[:policy_url].any?,   "Missing Policy URL doesn't show error"
  end

  test "Country Code only accepts two characters" do
    organisation = Organisation.new(country_code: 'USA')
    assert organisation.invalid?
    assert organisation.errors[:country_code].any?
  end

  test "Returns correct country name using the country_code" do
    organisation = Organisation.new(country_code: 'MW')
    assert_equal 'Malawi', organisation.country_name
  end

  test "Correctly identifies a NRO" do
    operator = organisations(:maren)
    assert operator.is_an_operator?
  end

  test "Correctly rejects a non-NRO" do
    non_operator = organisations(:chanco)
    assert_not non_operator.is_an_operator?
  end

end
