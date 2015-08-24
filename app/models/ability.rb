class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'owner'
      # owner
      can :manage, :all
    elsif user.role == 'manager'
      # manager
      can :read, :all
      can :update, Client
    elsif user.role == 'employee'
      # employee
      can :read, :all
      can [:edit, :update, :change_password, :update_password], User, id: user.id
    else
      can :read, :all
    end

    # You can pass an array for either of these parameters to match any one.
    # For example, here the user will have the ability to update or destroy
    # both articles and comments.
    # can [:update, :destroy], [Article, Comment]

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
