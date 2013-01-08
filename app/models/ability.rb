class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index,:create,:update], Familiar
    can [:create,:update,:destroy], Sale
  end
end
