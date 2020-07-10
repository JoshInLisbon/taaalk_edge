class TlkPolicy < ApplicationPolicy
  def initialize(user, tlk)
    @user = user
    @tlk = tlk
  end

  def index?
    return true
  end

  def update?
    @tlk.user == user
  end
end
