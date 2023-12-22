class SpaPolicy < ApplicationPolicy

  def create?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    user.role == 'host' && record.user == user
  end

  def destroy?
    user.role == 'host' && record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
