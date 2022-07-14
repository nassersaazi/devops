require 'test_helper'

class OrganisationPolicyTest < ActiveSupport::TestCase

  setup do
    @organisation = organisations(:maren)
    @operator = users(:opareto)
  end

  test 'an admin can' do
    assert_permit users(:admin), Organisation, [:index?, :new?, :create?]
    assert_permit users(:admin), @organisation, [:show?, :edit?, :update?]
  end

  test 'an operator can access new organisations in her federation' do
    assert_permit @operator, Organisation, [:new?]
  end

  test 'an operator can create new organisations in her federation' do
    assert_permit @operator, @organisation, [:create?]
  end

  test 'an operator cannot create new organisations in another federation' do
    refute_permit @operator, organisations(:ternet), [:create?]
  end

  test 'an operator can see and edit organisations in his federation' do
    assert_permit @operator, organisations(:ua), [:show?, :edit?, :update?, :destroy?]
  end

  test 'an operator cannot see and edit organisations another federation' do
    refute_permit @operator, organisations(:ternet), [:show?, :edit?, :update?]
  end

end