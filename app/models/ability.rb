class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    if user.is_root?
      can :manage, :all
    elsif user.is_admin?
      can :manage, :all #管理者暂时拥有全部权限，为以后修改准备
    elsif user.is_member?
      can :create, Topic
      can [:update, :destroy], Topic do |topic|
         topic.user_id == user.id
     end

      can :create, Comment
      can [:destroy], Comment do |comment|
        comment.user_id == user.id
      end
       
      can :update, User do |update_user|
        update_user.id == user.id 
      end   
    else
       can :read, :all 
    end
  end
end
