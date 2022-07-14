require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "Member is recognized" do
    user = users(:noop)
    organisation = organisations(:maren)
    assert_equal true, user.is_member?(organisation)
  end

  test "Operator is recognized" do
    user = users(:opareto)
    federation = federations(:mw)
    assert_equal true, user.is_operator?(federation)
  end

  test "Non-Operator is recognized" do
    user = users(:noop)
    federation = federations(:mw)
    assert_equal false, user.is_operator?(federation)
  end

  test "Member or Operator is recognized" do
    user = users(:noop)
    organisation = organisations(:maren)    
    federation = federations(:mw)
    assert_equal true, user.is_member_or_operator?(organisation)
    assert_equal false, user.is_member_or_operator?(federation)
  end

  test "Operator see his federation" do
    user = users(:opareto)
    assert_includes user.operated_federations, federations(:mw)
  end

  test "Operator see his operated organisations" do
    user = users(:opareto)
    federation = federations(:mw)
    assert_includes user.operated_organisations, organisations(:maren)
    assert_includes user.operated_organisations, organisations(:ua)
    # assert_includes user.operated_organisations, organisations(:chanco)
  end

end
