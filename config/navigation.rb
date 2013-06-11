SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected'
  navigation.active_leaf_class = 'active_leaf'

  navigation.items do |primary|
    primary.item :dashboard, t('app.title.dashboard'), root_path

    primary.item :mandators, Mandator.model_name.human(:count => 2),
      mandators_path, :highlights_on => %r(/mandators),
      :if => Proc.new {can? :show, Mandator}

    primary.item :users, User.model_name.human(:count => 2),
      users_path, :highlights_on => %r(/users),
      :if => Proc.new {can? :show, User}

    primary.item :messages, Message.model_name.human(:count => 2),
      messages_path, :highlights_on => %r(/messages),
      :if => Proc.new {can? :show, Message}

    primary.item :changes, 'Tracking',
      changes_path, :highlights_on => %r(/changes),
      :if => Proc.new {current_user.has_role? :meta_admin}
  end
end
