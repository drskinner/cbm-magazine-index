class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # account for users not logged in

    case user.role.name
    when 'gsa'
      can :manage, :all
      cannot :destroy, Magazine

    when 'archivist'
      can :manage, Article

    when 'guest'
      can :read, :all
      cannot :manage, User
    end
  end
end
