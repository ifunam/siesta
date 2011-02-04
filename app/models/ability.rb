class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    send(@user.role.to_sym)
  end

  def manager
    can :manage, :all
  end

  def academic 
    can :update, UserRequest
  end
end
