class FederationPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      else
        scope.includes(:organisations).where(organisations: { id: user.organisations })
      end
    end

  end

  def show?
    is_admin_or_operator?
  end

  def update?
    is_admin_or_operator?
  end

  def users?
    is_admin_or_operator?
  end


  private
  def is_admin_or_operator?
    user.admin? or user.is_operator?(record)    
  end
end