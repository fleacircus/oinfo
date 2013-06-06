class Ability
  include CanCan::Ability

  # Don't forget to define translations for the roles
  # in config/locales/models/ability/<locale>.yml

  def initialize(user)

    # MetaAdmin
    can :manage, :all if user.has_role? :meta_admin

    # Users can edit their account
    can :update, User, :id => user.id
    # Version 2.0 will restricted also attributes:
    #   cannot :update, User, [:activated, :role_ids] if !user.has_role? 'meta_admin'
    #
    # see https://github.com/ryanb/cancan/tree/2.0#resource-attributes

    # MandatorAdmins can manage their associated user
    can :manage, User if user.has_role? :mandator_admin

  end
end
