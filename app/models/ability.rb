class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'owner'
      can :manage, :all
    elsif user.role == 'manager'
      can :read, :all
      can [:update, :edit], Client
    elsif user.role == 'employee'
      can :read, :all
      can [:edit, :update, :change_password, :update_password], User, id: user.id
    end
  end
end
