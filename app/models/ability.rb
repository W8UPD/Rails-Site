class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    if user.in_role? 'officer'
      can :manage, :all
    else
      can :read, :all
      cannot :read, [User]
    end
  end
end
