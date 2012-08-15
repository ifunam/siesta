class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    send(@user.role.to_sym) unless @user.role.nil?
  end

  def manager
    can :manage, :all
  end

  def academic
    can :manage, :all
  end
end
