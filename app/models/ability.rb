class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, :all if user.role?('meta_admin')

    can :update, User, :id => user.id
    # version 2.0 will restricted also attributes
    # cannot :update, User, :role_ids if !user.role?('meta_admin')
    # see https://github.com/ryanb/cancan/tree/2.0#resource-attributes

  end
end
