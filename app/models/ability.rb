class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index,:create], Familiar
    can [:create,:destroy], Sale
  end
end
