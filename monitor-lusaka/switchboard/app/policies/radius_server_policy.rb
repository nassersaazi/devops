class RadiusServerPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(organisaton_id: user.organisations )
      end
    end

  end

  def show?
    is_admin_member_or_operator?
  end

  def create?
    is_admin_member_or_operator?
  end

  def update?
    is_admin_member_or_operator?
  end

  def destroy?
    is_admin_member_or_operator?
  end

  def clients?
    is_admin_member_or_operator?
  end

  def proxy?
    is_admin_member_or_operator?
  end

  def users?
    is_admin_member_or_operator?
  end

  private
  def is_admin_member_or_operator?
    user.admin? or user.is_member_or_operator?(record.radiusable)   
  end

end