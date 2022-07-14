require 'test_helper'

class RealmPolicyTest < ActiveSupport::TestCase

  setup do
    @realm = realms(:ubuntunet_net)
    @organisation = organisations(:ua)
    @admin = users(:admin)
    @operator = users(:opareto)
    @manager = users(:mercedes)
  end

  test 'an admin can do all actions on Realms' do
    assert_permit @admin, Realm, [:index?, :new?, :create?]
    assert_permit @admin, @realm, [:show?, :edit?, :update?, :destroy?]
  end

  test 'an operator can access new realm form in his federations organisation' do
    assert_permit @operator, @organisation.realms.build, [:new?]
  end

  test 'an operator can CRUD realms in his federations organisation' do
    assert_permit @operator, @realm, [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'an operator cannot CRUD realms in another federations organisation' do
    refute_permit @operator, realms(:ternet_or_tz), [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'a manager can access new realm form in her organisation' do
    assert_permit @manager, @organisation.realms.build, [:new?]
  end

  test 'a manager can CRUD realms in her organisation' do
    assert_permit @operator, @realm, [:show?, :create?, :edit?, :update?, :destroy?]
  end

  test 'a manager cannot CRUD realms in another organisation' do
    refute_permit @manager, realms(:ternet_or_tz), [:show?, :create?, :edit?, :update?, :destroy?]
  end
end