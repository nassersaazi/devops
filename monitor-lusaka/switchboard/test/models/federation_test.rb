require 'test_helper'

class FederationTest < ActiveSupport::TestCase

  test "Mandatory attributes must not be empty" do
    rf = Federation.new
    assert rf.invalid?,          "Incomplete Federation is valid"
    assert rf.errors[:tld].any?, "Missing TLD doesn't show error"
    assert rf.errors[:info_url].any?, "Missing Info URL doesn't show error"
    assert rf.errors[:policy_url].any?, "Missing Policy URL doesn't show error"
    assert rf.errors[:operator].any?, "Missing Operator doesn't show error"
  end

  test "TLD only accepts two characters" do
    rf = Federation.new(tld: 'ORG')
    assert rf.invalid?
    assert rf.errors[:tld].any?
  end

  test "TLD needs to be unique" do
    rf = Federation.new(tld: 'MW')
    assert rf.invalid?
    assert rf.errors[:tld].any?
  end

  test "Stage default is Production/1" do
    rf = Federation.new
    assert_equal 1, rf.stage
  end

  test "Stage doesn't except value except 0/1" do
    rf = federations(:tz)
    assert rf.valid?, "Not valid with all attributes"
    rf.stage = 1
    assert rf.valid?, "Not valid with stage=1"
    rf.stage = 2
    assert rf.invalid?, "Accept 2 as value for stage"
  end


end
