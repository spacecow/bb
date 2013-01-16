class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index,:create,:update], Familiar
    can [:create,:update,:destroy], Sale
    can :show, Skill
  end
end
