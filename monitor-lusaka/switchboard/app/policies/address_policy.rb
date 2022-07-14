class AddressPolicy < ApplicationPolicy

  def create?
    user.admin? or user.is_member?(record.location.organisation)
  end

  def update?
    user.admin? or user.is_member?(record.location.organisation)
  end

  def destroy?
    user.admin? or user.is_member?(record.location.organisation)
  end

end