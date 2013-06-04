SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected'
  navigation.active_leaf_class = 'active_leaf'

  navigation.items do |primary|
    primary.item :dashboard, t('app.title.dashboard'), root_path
    primary.item :users, User.model_name.human, users_path, :if => Proc.new {can? :show, User}
  end
end
