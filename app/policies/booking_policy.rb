class BookingPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    true
  end

  def accept?
    record.spa.user == user
  end

  def reject?
    record.spa.user == user
  end

  class Scope < Scope
    def resolve
       scope.all
    end
  end
end
