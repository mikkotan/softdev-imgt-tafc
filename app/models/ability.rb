class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'owner'
      can :manage, :all
    elsif user.role == 'manager'
      can :read, :all
      can [:update, :edit], Client
      can :manage, Transaction
    elsif user.role == 'employee'
      can [:edit, :update, :change_password, :update_password], User, id: user.id
      can :read, Client, user_id: user.id
      can :manage, Transaction, :client => { :user_id => user.id }
      can :new, Transaction
    end
  end
end
