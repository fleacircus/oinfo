class Ability
  include CanCan::Ability

  # Don't forget to define translations for the roles
  # in config/locales/models/ability/<locale>.yml

  def initialize(user)

    alias_action :update, :destroy, :to => :modify

    # MetaAdmin
    if user.has_role? :meta_admin
      can :manage, :all

    # MandatorAdmin
    elsif user.has_role? :mandator_admin

      # MandatorAdmins can create and manage their associated user
      can :create, User
      can :read,   User, :mandator_id => user.mandator_id
      can :manage, User, :mandator_id => User.with_role(:mandator_admin, user).map(&:mandator_id)

      # MandatorAdmins can create and manage their associated messages
      can :create, Message
      can :read,   Message, :mandator_id => nil
      can :manage, Message, :mandator_id => user.mandator_id

      # MandatorAdmins can manage their associated changes
      can :manage, Version, :mandator_id => user.mandator_id

      # MandatorAdmins can manage their associated accounting date
      can :manage, Distributor, :mandator_id => user.mandator_id
      can :manage, Customer, :mandator_id => user.mandator_id
      can :manage, Invoice, :mandator_id => user.mandator_id

      # User can download their associated attachments
      can :download, Attachment, :mandator_id => user.mandator_id

    # User
    else

      # Users can edit their account
      can :update, User, :id => user.id
      # Version 2.0 will restricted also attributes:
      #   cannot :update, User, [:activated, :role_ids] if !user.has_role? 'meta_admin'
      #
      # see https://github.com/ryanb/cancan/tree/2.0#resource-attributes

      # User can read their associated messages
      can :read, Message, :mandator_id => [nil , user.mandator_id]

      # User can download their associated attachments
      can :download, Attachment, :mandator_id => user.mandator_id

    end

    # No one can delete his own account
    cannot :delete, User, :id => user.id

  end
end
