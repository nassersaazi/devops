require 'test_helper'

class LocationPolicyTest < ActiveSupport::TestCase

  setup do
    @location = locations(:kitchen)
    @organisation = organisations(:ua)
    @admin = users(:admin)
    @operator = users(:opareto)
    @manager = users(:mercedes)
  end

  test 'an admin can do all actions on locations' do
    assert_permit @admin, Location, [:index?, :new?, :create?]
    assert_permit @admin, @location, [:show?, :edit?, :update?, :destroy?]
  end

  test 'an operator can access new locations form in his federations organisation' do
    assert_permit @operator, @organisation.locations.build, [:new?]
  end

  test 'an operator can CRUD realms in his federations organisation' do
    assert_permit @operator, @location, [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'an operator cannot CRUD realms in another federations organisation' do
    refute_permit @operator, locations(:costech), [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'a manager can access new realm form in her organisation' do
    assert_permit @manager, @organisation.locations.build, [:new?]
  end

  test 'a manager can CRUD realms in her organisation' do
    assert_permit @operator, @location, [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'a manager cannot CRUD realms in another organisation' do
    refute_permit @manager, locations(:costech), [:show?, :create?, :edit?, :update?, :destroy?]
  end
end