require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase

  setup do
    @user = users(:noop)
    @operator = users(:opareto)
  end

  test 'an operator can see and edit users in his organisation' do
    assert_permit @operator, @user, [:show?, :edit?, :update?]
  end

  test 'an operator cannot see and edit members of another organisation' do
    refute_permit @operator, users(:simba), [:show?, :edit?, :update?]
  end

  test 'a user cannot see and edit other users' do
    refute_permit users(:mercedes), @operator, [:show?, :edit?, :update?]
  end

end