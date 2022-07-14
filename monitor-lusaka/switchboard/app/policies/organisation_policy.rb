class OrganisationPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      elsif user.is_an_operator?
        scope.where(federation: user.operated_federations)
      else
        scope.where(id: user.organisations )
      end
    end
  end

  def show?
    is_admin_operator_or_manager?
  end

  def new?
    user.admin? or user.is_an_operator?
  end

  def create?
    user.admin? or user.is_operator?(record.federation)
  end

  def update?
    is_admin_operator_or_manager?
  end

  def destroy?
    is_admin_operator_or_manager?
  end

  private
  def is_admin_operator_or_manager?
    user.admin? or user.is_operator?(record.federation) or user.is_member?(record)
  end

end
