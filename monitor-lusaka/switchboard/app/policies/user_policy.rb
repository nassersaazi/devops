class UserPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      elsif user.is_an_operator?
        scope.joins(:organisations).where(organisations: { id: user.operated_organisations.ids })
      else
        scope.none
      end
    end

  end

  def show?
    user.admin? or !(record.organisations & user.operated_organisations).empty?
  end

  def update?
    user.admin? or !(record.organisations & user.operated_organisations).empty?
  end

end