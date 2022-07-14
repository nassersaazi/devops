require 'test_helper'

class EquipmentPolicyTest < ActiveSupport::TestCase

  setup do
    @equipment = equipment(:unifi)
  end

  test 'an admin can' do
    assert_permit users(:admin), Equipment, [:index?, :new?, :create?]
    assert_permit users(:admin), @equipment, [:show?, :edit?, :update?]
  end

  # test 'a manager can create a new equipment' do
  #   assert_permit users(:mercedes), Equipment, [:new?, :create?]
  # end

  test 'a manager can see and edit his equipment' do
    assert_permit users(:mercedes), @equipment, [:show?, :edit?, :update?]
  end

  test 'a user cannot see and edit equipment' do
    refute_permit users(:orglos), @equipment, [:show?, :edit?, :update?]
  end

end