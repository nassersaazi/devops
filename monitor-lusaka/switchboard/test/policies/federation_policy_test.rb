require 'test_helper'

class FederationPolicyTest < ActiveSupport::TestCase

  setup do
    @federation = federations(:mw)
  end

  test 'an admin can' do
    assert_permit users(:admin), Federation, [:index?, :new?, :create?]
    assert_permit users(:admin), @federation, [:show?, :edit?, :update?]
  end

  test 'an operator cannot create a new federation' do
    refute_permit users(:opareto), Federation, [:new?, :create?]
  end

  test 'an operator can see and edit his federation' do
    assert_permit users(:opareto), @federation, [:show?, :edit?, :update?]
  end

  test 'an operator cannot see and edit another federation' do
    refute_permit users(:opareto), federations(:tz), [:show?, :edit?, :update?]
  end

end