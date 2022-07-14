class MembershipPolicy < ApplicationPolicy

  def show?
    is_admin_operator_or_manager?
  end

   def create?
    is_admin_operator_or_manager?
  end

  def update?
    is_admin_operator_or_manager?
  end

  def destroy?
    is_admin_operator_or_manager?
  end

  private
  def is_admin_operator_or_manager?
    user.admin? or user.is_operator?(record.organisation.federation) or user.is_member?(record.organisation)
  end

end